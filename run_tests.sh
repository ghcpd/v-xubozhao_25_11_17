#!/usr/bin/env bash
set -euo pipefail

# Ensure virtualenv is activated if it exists
if [ -d ".venv" ]; then
  source .venv/bin/activate
fi

mkdir -p logs
pytest -q --junit-xml=logs/junit.xml 2>&1 | tee logs/test_output.log
