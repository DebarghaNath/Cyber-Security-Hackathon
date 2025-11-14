# setup.ps1
# PowerShell script to setup Python 3.11 venv and install requirements

$ErrorActionPreference = "Stop"

# Project directory
$PROJECT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
$VENV_DIR = Join-Path $PROJECT_DIR ".venv"
$PYTHON_EXE = "python.exe"

# Function to check Python version
function Test-Python {
    try {
        $ver = & $PYTHON_EXE --version 2>$null
        return $ver -match "Python 3\.11"
    } catch {
        return $false
    }
}

# Install Python 3.11 if missing
if (-not (Test-Python)) {
    Write-Host "Python 3.11 not found. Installing..."
    $installerUrl = "https://www.python.org/ftp/python/3.11.7/python-3.11.7-amd64.exe"
    $installerPath = Join-Path $env:TEMP "python-3.11.7-amd64.exe"

    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
    Write-Host "Running Python installer..."
    Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

    Remove-Item $installerPath
}

# Ensure python is on PATH now
$PYTHON_EXE = "python"

# Create virtual environment
if (-not (Test-Path $VENV_DIR)) {
    & $PYTHON_EXE -m venv $VENV_DIR
}

# Activate venv for current session
$activateScript = Join-Path $VENV_DIR "Scripts\Activate.ps1"
. $activateScript

# Upgrade pip and install requirements
pip install --upgrade pip
pip install -r (Join-Path $PROJECT_DIR "requirements.txt")

Write-Host "Setup complete. Activate the venv with:`n$activateScript"
