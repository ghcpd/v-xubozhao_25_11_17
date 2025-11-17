# Obsolete / Deprecated Warnings

- `numpy==1.18.0` is an old release (2019). Upgrading to 2.3.5 requires checking for code that relies on old casting or array API behaviors.
- `pandas==0.25.3` (2019) is very old. Pandas 2.x introduced many API changes and Python requirements; code using `pandas` may break where dtype handling changed or deprecated functions were removed.
- `requests==2.19.1` (2018) should be upgraded for TLS and security fixes. Old versions may not properly validate modern TLS or SNI and can contain vulnerability fixes introduced in later releases.
- `scikit-learn==0.22` (2019) is incompatible with recent Python releases and has many API changes vs 1.7.2. Check for changed estimator behavior, deprecations, and changes to `fit`/`predict` shapes.
- `Flask==1.0` is obsolete. Upgrading to 3.x may require code changes, especially if using CLI commands, blueprint registration, or relying on older versions of extensions.
- `pytest==5.0.1` (2019) is outdated; upgrading to 9.x ensures support for newer fixtures and plugin ecosystems.

Recommendation: Run the project's test suite (existing tests, not only smoke tests added here) under the updated environment and verify behavior. Introduce a staging environment before production rollout.
