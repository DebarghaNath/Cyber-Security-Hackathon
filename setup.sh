set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PYTHON=${PYTHON:-python3.11}

if ! command -v "$PYTHON" >/dev/null 2>&1; then
echo "Error: $PYTHON not found. Install Python 3.11 or set PYTHON env var to your python executable."
exit 1
fi

$PYTHON -m venv "$PROJECT_DIR/.venv"
source "$PROJECT_DIR/.venv/bin/activate"

pip install --upgrade pip
pip install -r "$PROJECT_DIR/requirment.txt"

echo "Setup complete. Activate the venv with: source $PROJECT_DIR/.venv/bin/activate"