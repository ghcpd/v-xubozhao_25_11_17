import sys


def major_minor_tuple(version_str):
    parts = version_str.split('.')
    try:
        major = int(parts[0])
    except ValueError:
        major = 0
    minor = int(parts[1]) if len(parts) > 1 and parts[1].isdigit() else 0
    return major, minor


def assert_version_at_least(package_version, expected_major, expected_minor):
    actual = major_minor_tuple(package_version)
    assert actual >= (expected_major, expected_minor), f"Version {package_version} < {expected_major}.{expected_minor}"


def test_numpy_basic():
    import numpy as np
    assert_version_at_least(np.__version__, 2, 3)
    a = np.array([1, 2, 3])
    assert a.sum() == 6


def test_pandas_basic():
    import pandas as pd
    assert_version_at_least(pd.__version__, 2, 3)
    df = pd.DataFrame({"a": [1, 2, 3]})
    assert df['a'].sum() == 6


def test_requests_basic():
    import requests
    assert_version_at_least(requests.__version__, 2, 32)
    # verify basic API (no network call)
    s = requests.structures.CaseInsensitiveDict({'A': 'b'})
    assert 'a' in s


def test_sklearn_basic():
    import sklearn
    assert_version_at_least(sklearn.__version__, 1, 7)
    from sklearn.linear_model import LinearRegression
    # instantiate basic estimator
    _ = LinearRegression()


def test_flask_basic():
    import flask
    assert_version_at_least(flask.__version__, 3, 1)
    app = flask.Flask(__name__)
    assert app.name == __name__


def test_pytest_version():
    import pytest
    assert_version_at_least(pytest.__version__, 9, 0)
