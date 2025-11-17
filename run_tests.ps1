# PowerShell test runner (pwsh)
param(
    [string]$VenvDir = ".venv"
)

if (Test-Path $VenvDir) {
    & $VenvDir\Scripts\Activate.ps1
}

New-Item -ItemType Directory -Force -Path logs | Out-Null
pytest -q --junit-xml=logs/junit.xml 2>&1 | Tee-Object -FilePath logs/test_output.log
