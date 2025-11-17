@echo off
REM Test runner script - executes pytest and generates logs (Windows)
REM This script runs the test suite and captures output

setlocal enabledelayedexpansion

echo.
echo ==========================================
echo Running Test Suite
echo ==========================================
echo.

REM Check if virtual environment is activated
if "%VIRTUAL_ENV%"=="" (
    echo [WARNING] Virtual environment not activated. Attempting to activate...
    call venv\Scripts\activate.bat
)

echo [OK] Python environment:
python --version
echo.

REM Create test directory if not exists
if not exist "tests\" (
    echo [*] Creating tests directory...
    mkdir tests
)

REM Create logs directory
if not exist "logs\" (
    echo [*] Creating logs directory...
    mkdir logs
)

REM Generate timestamp
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set TIMESTAMP=%mydate%_%mytime%
set LOG_FILE=logs\test_run_%TIMESTAMP%.log

echo [*] Running tests with pytest...
echo [*] Output will be saved to: %LOG_FILE%
echo.

REM Run pytest with verbose output and generate reports
pytest tests\ -v --tb=short ^
    --junit-xml=logs\test_results_%TIMESTAMP%.xml ^
    --html=logs\test_report_%TIMESTAMP%.html ^
    --self-contained-html 2>&1 | tee "%LOG_FILE%"

set TEST_EXIT_CODE=%ERRORLEVEL%

echo.
echo ==========================================
if %TEST_EXIT_CODE% equ 0 (
    echo [OK] All tests passed!
) else (
    echo [ERROR] Some tests failed (exit code: %TEST_EXIT_CODE%)
)
echo ==========================================
echo.
echo Test artifacts generated:
echo    * Test log: %LOG_FILE%
echo    * JUnit XML: logs\test_results_%TIMESTAMP%.xml
echo    * HTML Report: logs\test_report_%TIMESTAMP%.html
echo.

endlocal
exit /b %TEST_EXIT_CODE%
