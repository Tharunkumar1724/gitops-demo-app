$version = Get-Content VERSION
$port = 8000

# Stop existing app
Get-Process -Name python -ErrorAction SilentlyContinue |
  Where-Object {$_.Path -like "*uvicorn*"} |
  Stop-Process -Force

# Activate venv
cd backend
if (!(Test-Path venv)) {
  python -m venv venv
}
.\venv\Scripts\Activate.ps1
pip install -q fastapi uvicorn

# Start app
Start-Process powershell -ArgumentList `
  "uvicorn main:app --host 0.0.0.0 --port $port" `
  -WindowStyle Hidden
