from flask import Flask, request, jsonify
from flask_cors import CORS 
import os
import tempfile
import cv2
import mediapipe as mp
import numpy as np

mp_face = mp.solutions.face_mesh
face_mesh = mp_face.FaceMesh(
    static_image_mode=True,
    refine_landmarks=True,
    max_num_faces=1
)

app = Flask(__name__)
CORS(app)  

def save_temp_file(file_storage):
    tmp = tempfile.NamedTemporaryFile(delete=False, suffix=os.path.splitext(file_storage.filename)[1])
    file_storage.save(tmp.name)
    tmp.close()
    return tmp.name

def mediapipe_Face(image_path):
    image = cv2.imread(image_path)
    image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    result = face_mesh.process(image_rgb)
    return result, image.shape[:2]  # return height, width for normalization

# Select key landmark indices (MediaPipe FaceMesh 468 landmarks)
KEY_LANDMARKS = {
    "left_eye": [33, 133],      # outer and inner corners
    "right_eye": [362, 263],    # outer and inner corners
    "nose_tip": [1],
    "mouth": [78, 308]          # left and right corners
}

def extract_keypoints(face_result, image_shape):
    h, w = image_shape
    keypoints = {}
    if face_result.multi_face_landmarks:
        landmarks = face_result.multi_face_landmarks[0].landmark
        for part, indices in KEY_LANDMARKS.items():
            pts = []
            for idx in indices:
                lm = landmarks[idx]
                # normalize coordinates by image width and height
                pts.append([lm.x, lm.y])
            keypoints[part] = np.array(pts)
    return keypoints

def compute_similarity(kp1, kp2):
    # Compute distance between eyes, nose, mouth after normalization
    score = 0
    count = 0
    for part in kp1:
        if part in kp2:
            # compute mean Euclidean distance between corresponding points
            dist = np.linalg.norm(kp1[part] - kp2[part], axis=1).mean()
            score += dist
            count += 1
    # Smaller distance -> higher similarity
    similarity_score = max(0, 1 - score)  # simple scale: 0 (different) to 1 (same)
    return similarity_score

@app.route('/match', methods=['POST'])
def match():
    if 'imageA' not in request.files or 'imageB' not in request.files:
        return jsonify({'error': 'Require imageA and imageB files'}), 400

    fA = request.files['imageA']
    fB = request.files['imageB']

    pathA = save_temp_file(fA)
    pathB = save_temp_file(fB)

    try:
        face1, shape1 = mediapipe_Face(pathA)
        face2, shape2 = mediapipe_Face(pathB)

        kp1 = extract_keypoints(face1, shape1)
        kp2 = extract_keypoints(face2, shape2)

        similarity = compute_similarity(kp1, kp2)

        return jsonify({
            'similarity_score': similarity,
            'keypoints_imageA': {k: v.tolist() for k, v in kp1.items()},
            'keypoints_imageB': {k: v.tolist() for k, v in kp2.items()}
        })
    finally:
        try:
            os.remove(pathA)
            os.remove(pathB)
        except Exception:
            pass

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
