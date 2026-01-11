@echo off
REM === Start AmneziaWG ===
start "" "C:\Program Files\AmneziaWG\AmneziaWG.exe"

REM === Enable split routing ===
powershell -NoProfile -ExecutionPolicy Bypass ^
  -File "%~dp0amnezia-on.ps1"
