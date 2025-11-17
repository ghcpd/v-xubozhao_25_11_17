# Dependency Upgrade Assessment Report

Date: 2025-11-17

## Summary
This project contained a set of significantly outdated dependencies. I upgraded each dependency to the latest stable version (as of 2025-11-17) and added reproducible scripts to bootstrap an isolated environment and run tests.

## Dependency Diff
| Package | Current (requirements_old.txt) | Updated (requirements.txt) |
|---|---:|---:|
| numpy | 1.18.0 | 2.3.5 |
| pandas | 0.25.3 | 2.3.3 |
| requests | 2.19.1 | 2.32.5 |
| scikit-learn | 0.22 | 1.7.2 |
| Flask | 1.0 | 3.1.2 |
| pytest | 5.0.1 | 9.0.1 |

## Warnings & Obsolete Packages
- No listed packages are removed or renamed, but the old versions are extremely out-of-date and may contain security vulnerabilities.
- Major version jumps (e.g. pandas 0.25 → 2.3, NumPy 1.18 → 2.3) may include breaking API, deprecations, and performance/behavior changes. Review code for:
  - pandas: changes in deprecated/removed APIs (e.g., .ix, behavior of categorical types, dtype changes, timezone handling.)
  - numpy: changes in type behavior, scalar casting, and numerical algorithms.
  - scikit-learn: many API changes and Python version requirements (sklearn 1.7 requires Python >= 3.10).
  - Flask: many internal changes; Flask 2.x/3.x changed default CLI behaviors and dependencies.
- If your code targets older Python versions, you'll need to update it to Python 3.10+ to use the new scikit-learn, and newer NumPy / pandas releases.

## Upgrade Decisions
- I pinned each dependency to the latest stable release available on PyPI as of 2025-11-17 to produce a reproducible environment.
- pytest was upgraded to 9.x to ensure compatibility with testing features and the test runner used by scikit-learn tests.

## Test Strategy
- Created a lightweight `tests/test_smoke.py` to verify package imports and basic functionality without external network calls.
- Tests assert minimal API functionality and version checks (major.minor) to ensure the installed packages meet the minimum required major/minor versions.

## How to reproduce

Reproduce in one command:

- PowerShell (Windows / pwsh): `pwsh -NoProfile -ExecutionPolicy Bypass -File .\\reproduce.ps1`
- Bash / POSIX: `bash reproduce.sh`

Or run scripts separately:

- PowerShell: `pwsh -NoProfile -ExecutionPolicy Bypass -File .\\setup.ps1` then `pwsh -NoProfile -ExecutionPolicy Bypass -File .\\run_tests.ps1`.
- Bash: `bash setup.sh && bash run_tests.sh`.

## Additional notes
- Test output and junit XML are stored in `logs/` after running `run_tests`.
- Consider using `pip-tools` or `poetry` to manage dependency resolution in the future.
- Before upgrading in production, run test runs on the full application and verify backwards compatibility. A major version bump might require changes to the code base.

## Test logs
- To run tests after creating the environment: `bash run_tests.sh` or on PowerShell: `pwsh -NoProfile -ExecutionPolicy Bypass -File .\\run_tests.ps1`

1. Run one of the setup scripts (PowerShell for Windows or bash for Unix):
   - PowerShell: `.uild\setup.ps1` OR `.










- Consider using `pip-tools` or `poetry` to manage dependency resolution in the future.- Before upgrading in production, run test runs on the full application and verify backwards compatibility. A major version bump might require changes to the code base.## Additional notes- Test output and junit XML are stored in `logs/` after running `run_tests`.## Test logs   - Once the environment is created, run: `bash run_tests.sh` or on PowerShell: `.
un_tests.ps1`   - Bash: `bash setup.sh`un_tests.ps1` (activate env if required)