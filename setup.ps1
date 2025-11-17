# PowerShell environment setup (Windows - PowerShell Core / pwsh)
param(
    [string]$VenvDir = ".venv"
)

$pythonExe = "${env:PYTHON:-}".Trim()
if ([string]::IsNullOrEmpty($pythonExe)) {
    $pythonExe = "C:/Users/v-xubozhao/AppData/Local/Programs/Python/Python313/python.exe"
}

Write-Host "Using Python: $pythonExe"
& $pythonExe -m venv $VenvDir
& $VenvDir\Scripts\Activate.ps1
& $VenvDir\Scripts\python.exe -m pip install --upgrade pip setuptools wheel
& $VenvDir\Scripts\python.exe -m pip install -r requirements.txt

Write-Host "Environment setup complete. To activate, run: & $VenvDir\Scripts\Activate.ps1"
