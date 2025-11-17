@echo off
REM Setup script for Python environment with updated dependencies (Windows)
REM This script creates a reproducible Python virtual environment

setlocal enabledelayedexpansion

echo.
echo ==========================================
echo Dependency Upgrade Environment Setup
echo ==========================================
echo.

REM Check if Python is available
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Python is not installed or not in PATH
    exit /b 1
)

echo [OK] Python version:
python --version
echo.

REM Create virtual environment
echo [*] Creating virtual environment...
if exist "venv\" (
    echo [WARNING] Virtual environment already exists. Skipping creation.
) else (
    python -m venv venv
    echo [OK] Virtual environment created
)
echo.

REM Activate virtual environment
echo [*] Activating virtual environment...
call venv\Scripts\activate.bat
echo [OK] Virtual environment activated
echo.

REM Upgrade pip, setuptools, wheel
echo [*] Upgrading pip, setuptools, and wheel...
python -m pip install --upgrade pip setuptools wheel >nul 2>&1
echo [OK] pip, setuptools, and wheel upgraded
echo.

REM Install dependencies
echo [*] Installing dependencies from requirements.txt...
pip install -r requirements.txt
echo [OK] Dependencies installed successfully
echo.

REM Verify installation
echo [*] Verifying installation...
pip list
echo.

echo ==========================================
echo [OK] Environment setup complete!
echo ==========================================
echo.
echo To activate the environment, run:
echo    venv\Scripts\activate.bat
echo.
echo To run tests, execute:
echo    run_tests.bat
echo.

endlocal
