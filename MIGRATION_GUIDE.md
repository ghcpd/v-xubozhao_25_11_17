"""
Migration guide for upgrading from legacy dependency versions.
This document provides code examples for breaking changes.
"""

# ============================================================================
# NUMPY MIGRATION GUIDE (1.18.0 → 1.26.4)
# ============================================================================

# Most code will work without changes. Key differences:
# - Some dtype handling improvements
# - Performance improvements in various operations
# - Better error messages

import numpy as np

# No significant breaking changes for typical usage
arr = np.array([1, 2, 3, 4, 5])
result = np.sum(arr)  # Works the same


# ============================================================================
# PANDAS MIGRATION GUIDE (0.25.3 → 2.1.4)
# ============================================================================

import pandas as pd

# ❌ OLD (0.25.3): Using DataFrame.append() - DEPRECATED AND REMOVED
df1 = pd.DataFrame({'A': [1, 2]})
df2 = pd.DataFrame({'A': [3, 4]})
# df_combined = df1.append(df2)  # This no longer works!

# ✅ NEW (2.1.4): Using pd.concat()
df_combined = pd.concat([df1, df2], ignore_index=True)

# ============================================================================
# Pandas: Index handling changes
# ============================================================================

# OLD: Chained assignment might work inconsistently
df = pd.DataFrame({'A': [1, 2, 3]})
# df['B'] = 0  # This now shows a warning for certain patterns

# NEW: Use explicit assignment
df['B'] = 0

# ============================================================================
# Pandas: Groupby changes
# ============================================================================

df = pd.DataFrame({
    'group': ['A', 'A', 'B', 'B'],
    'value': [1, 2, 3, 4]
})

# Most groupby operations work the same
result = df.groupby('group')['value'].sum()

# But some aggregation APIs have changed - use explicit methods
result = df.groupby('group').agg({'value': 'sum'})

# ============================================================================
# REQUESTS MIGRATION GUIDE (2.19.1 → 2.31.0)
# ============================================================================

import requests

# Basic usage remains the same
response = requests.get('https://api.example.com/data')
if response.status_code == 200:
    data = response.json()

# Sessions work the same
with requests.Session() as session:
    response = session.get('https://api.example.com/data')

# HTTPS is now the default and more secure
# Old code should just work better/more securely


# ============================================================================
# FLASK MIGRATION GUIDE (1.0 → 3.0.0)
# ============================================================================

from flask import Flask, jsonify

app = Flask(__name__)

# Basic route definition works the same
@app.route('/api/data')
def get_data():
    return jsonify({'status': 'ok'})

# Blueprint registration syntax is slightly improved
from flask import Blueprint

api = Blueprint('api', __name__, url_prefix='/api')

@api.route('/users')
def get_users():
    return jsonify([])

# Register blueprint (works same as before)
app.register_blueprint(api)

# JSON handling is improved
@app.route('/json')
def json_endpoint():
    return jsonify({'message': 'Hello'})  # Always returns proper JSON


# ============================================================================
# SCIKIT-LEARN MIGRATION GUIDE (0.22 → 1.3.2)
# ============================================================================

from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.datasets import load_iris

# Loading and basic usage remains the same
iris = load_iris()
X, y = iris.data, iris.target

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Estimator creation and fitting works the same
clf = DecisionTreeClassifier(random_state=42)
clf.fit(X_train, y_train)
score = clf.score(X_test, y_test)

# Some parameter names may have changed
# Check your specific estimators' documentation


# ============================================================================
# PYTEST MIGRATION GUIDE (5.0.1 → 7.4.3)
# ============================================================================

# Basic test structure remains the same
def test_addition():
    assert 1 + 1 == 2

# Fixtures work the same
import pytest

@pytest.fixture
def sample_data():
    return [1, 2, 3]

def test_with_fixture(sample_data):
    assert len(sample_data) == 3

# Parametrized tests
@pytest.mark.parametrize("input,expected", [
    (2, 4),
    (3, 9),
    (4, 16),
])
def test_square(input, expected):
    assert input ** 2 == expected


# ============================================================================
# SUMMARY OF KEY CHANGES
# ============================================================================

"""
1. PANDAS: DataFrame.append() → pd.concat()
   - Most common breaking change
   - concat is more flexible and performant

2. FLASK: Similar structure, but cleaner APIs
   - Most code will work with minimal changes
   - Better type hints in 3.0+

3. SCIKIT-LEARN: API mostly compatible
   - Some estimator parameters may have changed
   - Check estimator docstrings for parameter changes

4. REQUESTS: Now more secure by default
   - SSL/TLS handling improved
   - urllib3 dependency updated

5. NUMPY/PYTEST: Very compatible
   - Mostly drop-in replacements
   - Performance improvements expected
"""
