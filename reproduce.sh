#!/usr/bin/env bash
set -euo pipefail

# One-command reproduction of environment setup and tests
bash setup.sh
bash run_tests.sh

echo "Reproducible environment created and tests executed. Logs are under ./logs"
