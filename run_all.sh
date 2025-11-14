#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
VENV="$PROJECT_DIR/.venv"
BACKEND_SCRIPT="$PROJECT_DIR/app.py"
FRONTEND_DIR="$PROJECT_DIR/frontend"

# --- Step 1: Setup venv if missing ---
if [ ! -d "$VENV" ]; then
    echo "Virtualenv not found. Running setup..."
    ./setup.sh
fi

# --- Step 2: Start backend in a new terminal ---
echo "Starting Flask backend in a new terminal..."
gnome-terminal -- bash -c "source '$VENV/bin/activate'; cd '$PROJECT_DIR'; export FLASK_ENV=production; python '$BACKEND_SCRIPT'; exec bash"

# --- Step 3: Start frontend in a new terminal ---
if [ ! -d "$FRONTEND_DIR" ]; then
    FRONTEND_DIR="$PROJECT_DIR"
fi
echo "Starting frontend at http://localhost:8000 in a new terminal..."
gnome-terminal -- bash -c "cd '$FRONTEND_DIR'; python3 -m http.server 8000; exec bash"

# --- Step 4: Open browser automatically ---
xdg-open "http://localhost:8000"

echo "All done! Backend and frontend are running in separate terminals."
