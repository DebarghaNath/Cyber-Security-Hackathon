# backend.ps1
# PowerShell script to run Flask backend on Windows

$ErrorActionPreference = "Stop"

# Project directory
$PROJECT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
$VENV_DIR = Join-Path $PROJECT_DIR ".venv"
$ActivateScript = Join-Path $VENV_DIR "Scripts\Activate.ps1"

# Check if virtual environment exists
if (-not (Test-Path $ActivateScript)) {
    Write-Host "Virtualenv not found. Run .\setup.ps1 first."
    exit 1
}

# Activate the virtual environment
. $ActivateScript

# Change to project directory
Set-Location $PROJECT_DIR

# Set environment variable for Flask
$env:FLASK_ENV = "production"

# Run the Flask app
python app.py
