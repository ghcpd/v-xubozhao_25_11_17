# Dependency Upgrade Report

Summary of the dependency upgrade performed for this repository.

## Old dependencies (source: requirements_old.txt)
- numpy==1.18.0
- pandas==0.25.3
- requests==2.19.1
- scikit-learn==0.22
- flask==1.0
- pytest==5.0.1

## Upgrade decisions
- numpy: 1.18.0 → 2.1.3
  - Reason: 1.18 is long out-of-support; Numpy 2.x has many improvements (performance and Python 3.10+ compatibility). Chosen pinned 2.1.3 as representative modern stable.
- pandas: 0.25.3 → 2.2.3
  - Reason: 0.25 is deprecated and may not work with modern NumPy. Pandas 2.x is current major series.
- requests: 2.19.1 → 2.31.0
  - Reason: 2.19 is old and may contain vulnerabilities; 2.31.0 is a recent stable release in the 2.3x stream.
- scikit-learn: 0.22 → 1.3.2
  - Reason: scikit-learn 0.22 lacks many new models and fixes; 1.3.x is recent stable.
- flask: 1.0 → 2.3.3
  - Reason: Flask 1.0 is EOL; 2.3.x maintained support for modern Python and improved security.
- pytest: 5.0.1 → 8.3.3
  - Reason: Pytest 5 is obsolete; 8.x is current and supports modern fixtures and Python versions.

## Obsolete or risky packages
- flask==1.0 — End-of-life; security fixes no longer applied. Upgrade required.
- requests==2.19.1 — Too old; may have known CVEs.
- pandas==0.25.3 — EOL and API incompatible with current NumPy.

## Reproducible setup and testing
- `setup.sh` creates a virtualenv and installs the updated pinned dependencies from `requirements.txt`.
- `run_tests.sh` runs `pytest` and writes logs to `test-results/`.
- Tests: `tests/test_imports.py` verifies modules import and checks major version thresholds to be >= requested major series.

## How to reproduce
1. Run `bash setup.sh` (or on Windows: `.	ools






- If your project uses features requiring older API behavior, run the test suite and migration steps rather than pinning latest blindly.- Picking the latest exact patch versions may vary over time; choose minor updates if you want to avoid frequent pin churn.## Notes2. Activate the created venv and run `bash run_tests.sh`.un_script.ps1` if using the included PowerShell helper)