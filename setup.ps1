# run_all.ps1
$ErrorActionPreference = "Stop"

$PROJECT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
$VENV_DIR = Join-Path $PROJECT_DIR ".venv"
$BACKEND_SCRIPT = Join-Path $PROJECT_DIR "app.py"
$FRONTEND_DIR = Join-Path $PROJECT_DIR "frontend"
$SETUP_SCRIPT = Join-Path $PROJECT_DIR "setup.ps1"

function Write-Log($m){ Write-Host "[run_all] $m" }

# 1) Ensure venv exists (run setup if missing)
if (-not (Test-Path $VENV_DIR)) {
    if (Test-Path $SETUP_SCRIPT) {
        Write-Log "Virtualenv missing — running setup.ps1 (this will install Python 3.11 if needed)..."
        # Run setup in current session so we get venv created and can activate
        & $SETUP_SCRIPT
    } else {
        Write-Host "setup.ps1 not found. Please place setup.ps1 in the project root."
        Pause
        exit 1
    }
} else {
    Write-Log "Virtualenv found at $VENV_DIR"
}

# 2) Activate the venv for this session to ensure 'python' refers to venv python
$ActivateScript = Join-Path $VENV_DIR "Scripts\Activate.ps1"
if (-not (Test-Path $ActivateScript)) {
    Write-Host "Error: Activate script not found at $ActivateScript"
    Pause
    exit 1
}
. $ActivateScript
Write-Log "Activated virtual environment."

# 3) Start backend in new PowerShell window
if (-not (Test-Path $BACKEND_SCRIPT)) {
    Write-Host "Error: $BACKEND_SCRIPT not found."
    Pause
    exit 1
}
Write-Log "Starting backend (python $BACKEND_SCRIPT) in new window..."
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-ExecutionPolicy","Bypass",
    "-Command",
    "Set-Location '$PROJECT_DIR'; `$env:FLASK_ENV='production'; python '$BACKEND_SCRIPT'"
) -WindowStyle Normal

# 4) Start frontend server in new PowerShell window
if (-not (Test-Path $FRONTEND_DIR)) {
    Write-Log "Frontend folder not found; serving project root instead."
    $serveDir = $PROJECT_DIR
} else {
    $serveDir = $FRONTEND_DIR
}
Write-Log "Starting frontend http.server in $serveDir on port 8000..."
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-ExecutionPolicy","Bypass",
    "-Command",
    "Set-Location '$serveDir'; python -m http.server 8000"
) -WindowStyle Normal

# 5) Open browser to frontend
Start-Sleep -Seconds 1
Start-Process "http://localhost:8000"
Write-Log "All launched. Backend and frontend logs are in separate windows."
