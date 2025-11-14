# Cyber Security Hackathon - Face Matching App

A Python-based web application for face similarity matching using **MediaPipe** and **OpenCV**.  
The backend is built with **Flask**, and the frontend is a static HTML/JS interface.  

---

## Features

- Detects facial landmarks (eyes, nose tip, mouth) using MediaPipe.
- Computes similarity score between two uploaded images.
- Returns detailed keypoints for both images.
- Simple frontend interface for uploading and comparing faces.
- CORS enabled for cross-origin requests.

---

## Requirements

- **macOS**: Big Sur (11.0) or later  
- **Windows**: 10 or later  
- **Python**: 3.11.x  
- **RAM**: Minimum 8GB recommended  
- **Disk Space**: 500 MB for packages  

Python packages (auto-installed via `requirements.txt`):
flask
flask-cors
opencv-python
mediapipe
numpy



---

## Setup (macOS)

### 1. Clone the repository
```bash
git clone https://github.com/DebarghaNath/Cyber-Security-Hackathon.git
cd Cyber-Security-Hackathon
```
### 2. Create a virtual environment
```bash
python3.11 -m venv env
source env/bin/activate
```
### 3. Install dependencies
```bash
pip install --upgrade pip
pip install -r requirements.txt
```
### 4. Run The Backend
```bash
python app.py
```

### 5. Run The Frontend
```bash
go to the index.html file and do command L and command O
```
