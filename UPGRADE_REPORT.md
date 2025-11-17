# Dependency Upgrade Assessment

## Overview
- Source manifest: `requirements_old.txt`
- Generated manifest: `requirements.txt`
- Toolchain automation: `setup.sh` to create/update the virtual environment, `run_tests.sh` to capture pytest logs in `logs/pytest.log`.

## Version Diff
| Package | Old Version | Latest Stable | Notes |
| --- | --- | --- | --- |
| numpy | 1.18.0 | 2.3.5 | Old release lacks Python 3.11+ wheels and receives no bug/security fixes. |
| pandas | 0.25.3 | 2.3.3 | Pre-1.0 API deprecated; new release adds Python 3.10+ support. |
| requests | 2.19.1 | 2.32.5 | 2.19.1 is vulnerable to credential leak (CVE-2018-18074); patched upstream. |
| scikit-learn | 0.22 | 1.7.2 | Old estimator APIs deprecated; 1.x line improves performance and typing. |
| flask | 1.0 | 3.1.2 | Flask 1.0 reached EOL; depends on deprecated Werkzeug/Jinja versions. |
| pytest | 5.0.1 | 9.0.1 | New pytest adds async fixtures, rich assertions, and Python 3.12 support. |

## Obsolete / Risky Components
- `requests==2.19.1` – contains CVE-2018-18074 (auth header leak on redirects). Upgrade mandatory for security.
- `flask==1.0` – unmaintained floor; transitive vulnerabilities via Werkzeug 0.x. Considered obsolete for modern Python.
- `numpy`, `pandas`, `scikit-learn` releases pinned to 2019/2020 no longer receive wheels or bug fixes; upgrading avoids ABI issues when building extensions.

## Validation
1. `./setup.sh` – creates `.venv`, upgrades pip, installs pinned dependencies, and runs `pip check`.
2. `./run_tests.sh` – activates the same `.venv` and runs `pytest -vv`, teeing output to `logs/pytest.log` for auditability.

## Next Steps
- Commit `requirements.txt`, automation scripts, and `tests/` smoke suite.
- Integrate `run_tests.sh` into CI for automatic verification after dependency bumps.
