#!/bin/bash
# Setup script for Python environment with updated dependencies
# This script creates a reproducible Python virtual environment

set -e  # Exit on any error

echo "=========================================="
echo "Dependency Upgrade Environment Setup"
echo "=========================================="
echo ""

# Check if Python is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed or not in PATH"
    exit 1
fi

echo "✓ Python version:"
python3 --version
echo ""

# Create virtual environment
echo "📦 Creating virtual environment..."
if [ -d "venv" ]; then
    echo "⚠️  Virtual environment already exists. Skipping creation."
else
    python3 -m venv venv
    echo "✓ Virtual environment created"
fi
echo ""

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate
echo "✓ Virtual environment activated"
echo ""

# Upgrade pip, setuptools, wheel
echo "⬆️  Upgrading pip, setuptools, and wheel..."
python -m pip install --upgrade pip setuptools wheel > /dev/null 2>&1
echo "✓ pip, setuptools, and wheel upgraded"
echo ""

# Install dependencies
echo "📥 Installing dependencies from requirements.txt..."
pip install -r requirements.txt
echo "✓ Dependencies installed successfully"
echo ""

# Verify installation
echo "🔍 Verifying installation..."
pip list
echo ""

echo "=========================================="
echo "✅ Environment setup complete!"
echo "=========================================="
echo ""
echo "📝 To activate the environment, run:"
echo "   source venv/bin/activate"
echo ""
echo "🧪 To run tests, execute:"
echo "   ./run_tests.sh"
echo ""
