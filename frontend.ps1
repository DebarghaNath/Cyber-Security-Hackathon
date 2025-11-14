# frontend.ps1
# PowerShell script to serve frontend on Windows

$ErrorActionPreference = "Stop"

# Determine frontend directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$FrontendDir = Join-Path $ScriptDir "frontend"

# Fallback if frontend folder doesn't exist
if (-not (Test-Path $FrontendDir)) {
    $FrontendDir = $ScriptDir
}

# Change to frontend directory
Set-Location $FrontendDir

Write-Host "Serving frontend at http://localhost:8000"

# Run Python simple HTTP server
python -m http.server 8000
