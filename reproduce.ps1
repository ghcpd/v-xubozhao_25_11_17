# PowerShell reproduction script
pwsh -NoProfile -ExecutionPolicy Bypass -File .\setup.ps1
pwsh -NoProfile -ExecutionPolicy Bypass -File .\run_tests.ps1
Write-Host "Reproducible environment created and tests executed. Logs are under .\logs"
