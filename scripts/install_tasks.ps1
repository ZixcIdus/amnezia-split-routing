# ===============================
# Install Scheduled Tasks
# ===============================

$BASE = Split-Path -Parent $MyInvocation.MyCommand.Path

schtasks /Create /TN "AmneziaSplitON" `
    /SC ONCE /ST 00:00 /RL HIGHEST /F `
    /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$BASE\amnezia-on.ps1`""

schtasks /Create /TN "AmneziaSplitOFF" `
    /SC ONCE /ST 00:00 /RL HIGHEST /F `
    /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$BASE\amnezia-off.ps1`""

Write-Host "[OK] Scheduled tasks installed"
Write-Host "Use: schtasks /Run /TN AmneziaSplitON"
Write-Host "Use: schtasks /Run /TN AmneziaSplitOFF"
