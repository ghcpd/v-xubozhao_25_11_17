#!/usr/bin/env bash
set -euo pipefail

python -m venv .venv

if [ -f .venv/bin/activate ]; then
  # POSIX-compatible environments
  source .venv/bin/activate
else
  # Windows (Git Bash, WSL) paths
  source .venv/Scripts/activate
fi

pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

cat <<'EOF'
Environment ready. Activate the virtualenv with:
  source .venv/bin/activate   # or .venv/Scripts/activate on Windows
EOF
