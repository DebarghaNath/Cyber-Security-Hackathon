set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PYTHON=${PYTHON:-python3.11}

if ! command -v "$PYTHON" >/dev/null 2>&1; then
    echo "$PYTHON not found. Installing Python 3.11..."
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install -y python3.11 python3.11-venv python3.11-distutils python3.11-dev
    PYTHON=python3.11
fi

$PYTHON -m venv "$PROJECT_DIR/.venv"
source "$PROJECT_DIR/.venv/bin/activate"

pip install --upgrade pip
pip install -r "$PROJECT_DIR/requirment.txt"

echo "Setup complete. Activate the venv with: source $PROJECT_DIR/.venv/bin/activate"
