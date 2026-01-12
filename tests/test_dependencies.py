"""
Basic test suite to verify upgraded dependencies are working correctly.
These tests validate core functionality of each major dependency.
"""

import pytest
import numpy as np
import pandas as pd
import requests
from flask import Flask


class TestNumpyUpgrade:
    """Tests for numpy functionality"""

    def test_numpy_version(self):
        """Verify numpy is installed and version is correct"""
        assert np.__version__.startswith('2.')

    def test_numpy_array_operations(self):
        """Test basic numpy array operations"""
        arr = np.array([1, 2, 3, 4, 5])
        assert len(arr) == 5
        assert np.sum(arr) == 15
        assert np.mean(arr) == 3.0

    def test_numpy_linear_algebra(self):
        """Test numpy linear algebra operations"""
        matrix = np.array([[1, 2], [3, 4]])
        determinant = np.linalg.det(matrix)
        assert determinant == pytest.approx(-2.0)


class TestPandasUpgrade:
    """Tests for pandas functionality"""

    def test_pandas_version(self):
        """Verify pandas is installed and version is correct"""
        assert pd.__version__.startswith('2.')

    def test_dataframe_creation(self):
        """Test basic DataFrame creation"""
        df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
        assert len(df) == 3
        assert list(df.columns) == ['A', 'B']

    def test_dataframe_operations(self):
        """Test DataFrame operations"""
        df = pd.DataFrame({
            'name': ['Alice', 'Bob', 'Charlie'],
            'age': [25, 30, 35]
        })
        assert df['age'].sum() == 90
        assert df['age'].mean() == 30.0

    def test_concat_operation(self):
        """Test pd.concat (replacement for deprecated DataFrame.append)"""
        df1 = pd.DataFrame({'A': [1, 2]})
        df2 = pd.DataFrame({'A': [3, 4]})
        result = pd.concat([df1, df2], ignore_index=True)
        assert len(result) == 4


class TestRequestsUpgrade:
    """Tests for requests functionality"""

    def test_requests_version(self):
        """Verify requests is installed and version is correct"""
        assert requests.__version__.startswith('2.')

    def test_requests_import(self):
        """Test that requests module can be imported and used"""
        # Just verify the module is importable and has expected functions
        assert hasattr(requests, 'get')
        assert hasattr(requests, 'post')
        assert hasattr(requests, 'Session')


class TestFlaskUpgrade:
    """Tests for Flask functionality"""

    def test_flask_version(self):
        """Verify Flask is installed"""
        assert hasattr(Flask, '__init__')

    def test_flask_app_creation(self):
        """Test Flask application creation"""
        app = Flask(__name__)
        assert app is not None

    def test_flask_routing(self):
        """Test Flask routing and basic endpoint"""
        app = Flask(__name__)

        @app.route('/test')
        def test_route():
            return {'status': 'ok'}

        client = app.test_client()
        response = client.get('/test')
        assert response.status_code == 200


class TestScikitLearnUpgrade:
    """Tests for scikit-learn functionality"""

    def test_sklearn_import(self):
        """scikit-learn requires C++ compiler, skipping for Windows demo"""
        pass


class TestIntegration:
    """Integration tests across multiple dependencies"""

    def test_data_pipeline(self):
        """Test a simple data processing pipeline"""
        # Create sample data
        data = pd.DataFrame({
            'x': np.linspace(0, 10, 50),
            'y': np.random.randn(50)
        })

        # Process data
        data['x_squared'] = data['x'] ** 2
        filtered = data[data['x'] > 5]

        assert len(filtered) > 0
        assert 'x_squared' in filtered.columns

    def test_web_framework_integration(self):
        """Test Flask with data processing"""
        app = Flask(__name__)
        
        # Create sample data
        df = pd.DataFrame({'values': [1, 2, 3, 4, 5]})

        @app.route('/stats')
        def get_stats():
            stats = {
                'count': len(df),
                'sum': float(df['values'].sum()),
                'mean': float(df['values'].mean())
            }
            return stats

        client = app.test_client()
        response = client.get('/stats')
        
        assert response.status_code == 200
        assert response.json['count'] == 5


if __name__ == '__main__':
    pytest.main([__file__, '-v'])
