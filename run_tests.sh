#!/usr/bin/env bash
set -euo pipefail

VENV_DIR=".venv"
LOG_DIR="logs"
mkdir -p "$LOG_DIR"

if [ -d "$VENV_DIR/Scripts" ]; then
  source "$VENV_DIR/Scripts/activate"
else
  source "$VENV_DIR/bin/activate"
fi

pytest -vv --color=yes 2>&1 | tee "$LOG_DIR/pytest.log"
