#!/bin/bash
# Test runner script - executes pytest and generates logs
# This script runs the test suite and captures output

set -e  # Exit on any error

echo "=========================================="
echo "Running Test Suite"
echo "=========================================="
echo ""

# Check if virtual environment is activated
if [ -z "$VIRTUAL_ENV" ]; then
    echo "⚠️  Virtual environment not activated. Attempting to activate..."
    source venv/bin/activate
fi

echo "✓ Python environment:"
python --version
echo ""

# Create test directory if not exists
if [ ! -d "tests" ]; then
    echo "📁 Creating tests directory..."
    mkdir -p tests
fi

# Create logs directory
if [ ! -d "logs" ]; then
    echo "📁 Creating logs directory..."
    mkdir -p logs
fi

# Generate timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="logs/test_run_${TIMESTAMP}.log"

echo "📝 Running tests with pytest..."
echo "📊 Output will be saved to: $LOG_FILE"
echo ""

# Run pytest with verbose output and generate JUnit XML report
pytest tests/ -v --tb=short \
    --junit-xml=logs/test_results_${TIMESTAMP}.xml \
    --html=logs/test_report_${TIMESTAMP}.html \
    --self-contained-html \
    2>&1 | tee "$LOG_FILE"

TEST_EXIT_CODE=${PIPESTATUS[0]}

echo ""
echo "=========================================="
if [ $TEST_EXIT_CODE -eq 0 ]; then
    echo "✅ All tests passed!"
else
    echo "❌ Some tests failed (exit code: $TEST_EXIT_CODE)"
fi
echo "=========================================="
echo ""
echo "📊 Test artifacts generated:"
echo "   • Test log: $LOG_FILE"
echo "   • JUnit XML: logs/test_results_${TIMESTAMP}.xml"
echo "   • HTML Report: logs/test_report_${TIMESTAMP}.html"
echo ""

exit $TEST_EXIT_CODE
