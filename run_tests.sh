#!/usr/bin/env bash
set -euo pipefail

if [ ! -d ".venv" ]; then
  echo "Virtualenv not found; please run ./setup.sh first."
  exit 1
fi

if [ -f .venv/bin/activate ]; then
  source .venv/bin/activate
else
  source .venv/Scripts/activate
fi

mkdir -p logs

echo "Running pytest..."
pytest tests --maxfail=1 --disable-warnings | tee logs/pytest.log

echo "Test log saved to logs/pytest.log"
