# Dependency Upgrade Assessment

## Version diff

| Package | Current (`requirements_old.txt`) | Latest stable | Notes |
| --- | --- | --- | --- |
| `numpy` | 1.18.0 | 2.3.5 | Modern release with improved typing support and bug fixes. |
| `pandas` | 0.25.3 | 2.3.3 | 2.x series guarantees Python 3.10+ compatibility and long-term fixes. |
| `requests` | 2.19.1 | 2.32.5 | Fixed TLS and redirection handling; 2.19 had known CVE-2019-9740. |
| `scikit-learn` | 0.22 | 1.7.2 | Introduces new estimators and deprecates legacy APIs used earlier. |
| `flask` | 1.0 | 3.1.2 | Drops Werkzeug/Microservices security issues addressed in 3.x. |
| `pytest` | 5.0.1 | 9.0.1 | Necessary to run the current test suite; latest release improves plugin API. |

## Obsolete/Deprecated libraries

- None of the listed dependencies are marked obsolete at the moment—each package still publishes releases and maintains security fixes. The main risk was using extremely old releases (e.g., `requests<2.20`), so the warning below summarizes the critical ones.

## Warnings

- Running old versions (especially `requests==2.19.1` and `flask==1.0`) exposes TLS proxy and session handling vulnerabilities that were patched years ago; upgrading mitigates them.
- The jump from `pandas 0.25` / `numpy 1.18` to the 2024 series means some deprecated APIs were removed; the automation tests demonstrate compatibility against the new stack.

## Automation notes

- `setup.sh` installs the pinned dependencies into `.venv` and upgrades `pip`.
- `run_tests.sh` assumes `.venv` exists, activates it, runs `pytest` under `tests/`, and saves console output into `logs/pytest.log`.

For reproducible environments, run `bash setup.sh` once and `bash run_tests.sh` whenever you need to rerun the suite.
