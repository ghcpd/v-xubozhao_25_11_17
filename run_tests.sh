#!/usr/bin/env bash
set -euo pipefail

# Activate venv if available
if [ -f venv/bin/activate ]; then
  echo "Activating virtualenv"
  # shellcheck disable=SC1091
  source venv/bin/activate
fi

# Run pytest and produce a JUnit-style XML and a textual log
mkdir -p test-results
pytest -q --maxfail=1 --junitxml=test-results/junit.xml 2>&1 | tee test-results/pytest.log
