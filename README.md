# Cyber Security Hackathon - Problem Statement 7 (PS-7) – Missing Person & Unidentified Dead Body (UIDB) Linkage Portal for Odisha Police


A Python-based web application for face similarity matching using **MediaPipe**   
The backend is built with **Flask**, and the frontend is a static HTML/JS interface.  

---

## Features

- Detects facial landmarks (eyes, nose tip, mouth) using MediaPipe.
- Computes similarity score between two uploaded images.
- Returns Similarity Score of Two Images.
- Simple frontend interface for uploading and comparing faces.
- CORS enabled for cross-origin requests.

---

## Requirements

- **macOS**: Big Sur (11.0) or later  
- **Python**: 3.11
- **RAM**: Minimum 8GB recommended  
- **Disk Space**: 500 MB for packages  

Python packages (auto-installed via `requirements.txt`):
flask
flask-cors
opencv-python
mediapipe
numpy



---<img width="790" height="335" alt="Screenshot 2025-11-14 at 5 46 21 PM" src="https://github.com/user-attachments/assets/8ce8f680-1f63-4fcc-85dc-2db33ec177f7" />


## Setup (macOS)

### 1. Clone the repository
```bash
git clone https://github.com/DebarghaNath/Cyber-Security-Hackathon.git
cd Cyber-Security-Hackathon
```
### 2. Create a virtual environment
install python3.11 before this step
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


## How To Use

![Example 1](https://raw.githubusercontent.com/YourUsername/Cyber-Security-Hackathon/main/)
