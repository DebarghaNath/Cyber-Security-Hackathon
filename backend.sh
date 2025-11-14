set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
VENV="$PROJECT_DIR/.venv"

if [ ! -d "$VENV" ]; then
echo "Virtualenv not found. Run ./setup.sh first."
exit 1
fi

source "$VENV/bin/activate"
cd "$PROJECT_DIR"

export FLASK_ENV=production

python app.py