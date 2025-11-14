set -euo pipefail

FRONTEND_DIR="$(cd "$(dirname "$0")" && pwd)/frontend"
if [ ! -d "$FRONTEND_DIR" ]; then

FRONTEND_DIR="$(cd "$(dirname "$0")" && pwd)"
fi

cd "$FRONTEND_DIR"
echo "Serving frontend at http://localhost:8000"
python3 -m http.server 8000