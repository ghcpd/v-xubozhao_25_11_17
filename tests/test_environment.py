import importlib.metadata as md


def test_numpy_pandas_integration():
    import numpy as np
    import pandas as pd

    data = np.arange(6).reshape(2, 3)
    df = pd.DataFrame(data, columns=list("abc"))
    assert df.iloc[1].to_list() == [3, 4, 5]
    assert df["a"].sum() == 3


def test_requests_and_versions():
    import requests

    ver = md.version("requests")
    assert tuple(int(p) for p in ver.split(".")[:2]) >= (2, 32)
    resp = requests.Request("GET", "https://example.com")
    assert resp.method == "GET"


def test_scikit_learn_pipeline():
    from sklearn.pipeline import Pipeline
    from sklearn.preprocessing import StandardScaler
    from sklearn.linear_model import LogisticRegression

    X = [[0, 0], [1, 1], [2, 2]]
    y = [0, 0, 1]

    pipe = Pipeline([
        ("scale", StandardScaler()),
        ("clf", LogisticRegression(max_iter=200)),
    ])
    pipe.fit(X, y)
    pred = pipe.predict([[1.5, 1.5]])
    assert pred[0] in (0, 1)


def test_flask_app_smoke():
    from flask import Flask

    app = Flask(__name__)

    @app.get("/ping")
    def ping():
        return {"status": "ok"}

    client = app.test_client()
    resp = client.get("/ping")
    assert resp.status_code == 200
    assert resp.get_json() == {"status": "ok"}
