#!/usr/bin/env bash
set -euo pipefail

VENV_DIR=".venv"
PYTHON_BIN="python3"

if command -v python >/dev/null 2>&1; then
  PYTHON_BIN="python"
fi

if [ ! -d "$VENV_DIR" ]; then
  "$PYTHON_BIN" -m venv "$VENV_DIR"
fi

if [ -d "$VENV_DIR/Scripts" ]; then
  # Windows venv layout
  source "$VENV_DIR/Scripts/activate"
else
  source "$VENV_DIR/bin/activate"
fi

python -m pip install --upgrade pip
python -m pip install --requirement requirements.txt

python -m pip check

cat <<EOF
Environment ready. Activate it with:
source $VENV_DIR/Scripts/activate  # on Windows Git Bash
source $VENV_DIR/bin/activate      # on macOS/Linux
EOF
