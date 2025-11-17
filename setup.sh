#!/usr/bin/env bash
set -euo pipefail

# Reproducible environment setup (POSIX)
if [ -z "${PYTHON:-}" ]; then
  PYTHON=python3
fi

VENV_DIR=".venv"

echo "Creating virtualenv in ${VENV_DIR}..."
$PYTHON -m venv ${VENV_DIR}
source ${VENV_DIR}/bin/activate
python -m pip install --upgrade pip setuptools wheel
python -m pip install -r requirements.txt

echo "Environment setup complete. To activate, run: source ${VENV_DIR}/bin/activate"
