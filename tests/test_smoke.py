import numpy as np
import pandas as pd
import requests


def test_numpy_mean():
    data = np.array([1.0, 2.0, 3.0])
    assert data.mean() == 2.0


def test_pandas_series_sum():
    series = pd.Series([1, 2, 3])
    assert series.sum() == 6


def test_requests_session_headers():
    session = requests.Session()
    session.headers.update({"X-Test-Purpose": "dependency-upgrade"})
    assert session.headers.get("X-Test-Purpose") == "dependency-upgrade"
