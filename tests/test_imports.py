import importlib
import sys

packages = {
    "numpy": ("2",),
    "pandas": ("2",),
    "requests": ("2",),
    "sklearn": ("1",),
    "flask": ("2",),
}


def test_can_import_packages():
    for pkg_name in packages:
        mod = importlib.import_module(pkg_name)
        assert mod is not None


def test_versions_are_not_ancient():
    import pkg_resources

    # Fail if any package is below major version threshold above
    for pkg_name, min_versions in packages.items():
        dist_name = 'scikit-learn' if pkg_name == 'sklearn' else pkg_name
        try:
            dist = pkg_resources.get_distribution(dist_name)
            version = dist.version
        except Exception:
            version = None

        assert version is not None, f"{dist_name} not installed or not resolved"
        # If a min major is specified, assert major >= specified
        min_major = int(min_versions[0])
        major = int(version.split('.')[0]) if version else 0
        assert major >= min_major, f"{dist_name} major version {major} is less than required {min_major}"
