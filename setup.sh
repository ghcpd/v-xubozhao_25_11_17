#!/usr/bin/env bash
set -euo pipefail

# Create a reproducible python virtualenv and install dependencies
VENV_DIR="venv"
PYTHON=${PYTHON:-python3}

if ! command -v ${PYTHON} &> /dev/null; then
  echo "Python not found: ${PYTHON}. Please install Python 3.8+ and try again."
  exit 1
fi

echo "Creating virtualenv in ${VENV_DIR}"
${PYTHON} -m venv ${VENV_DIR}

# shellcheck disable=SC1091
source ${VENV_DIR}/bin/activate

pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

echo "Environment created. Activate it with: source ${VENV_DIR}/bin/activate"
