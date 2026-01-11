# ===============================
# NetCheck - Diagnostics
# ===============================

Write-Host "=== NETCHECK ==="
Write-Host "Time:" (Get-Date)
Write-Host ""

# --- zapret ---
$zapret = Get-Process winws -ErrorAction SilentlyContinue
if ($zapret) {
    Write-Host "[OK] zapret (winws.exe) running" -ForegroundColor Green
} else {
    Write-Host "[WARN] zapret not running" -ForegroundColor Yellow
}

# --- split routes ---
$routes = (Get-NetRoute | Where-Object RouteMetric -eq 1337)
Write-Host "Routes metric=1337:" $routes.Count
Write-Host ""

# --- TCP check ---
function Test-Tcp($host, $port) {
    try {
        $client = New-Object System.Net.Sockets.TcpClient
        $iar = $client.BeginConnect($host, $port, $null, $null)
        if ($iar.AsyncWaitHandle.WaitOne(2000)) {
            $client.EndConnect($iar)
            $client.Close()
            Write-Host "[OK]  TCP $host:$port" -ForegroundColor Green
        } else {
            Write-Host "[FAIL] TCP $host:$port" -ForegroundColor Red
        }
    } catch {
        Write-Host "[FAIL] TCP $host:$port" -ForegroundColor Red
    }
}

Write-Host "=== TCP ==="
Test-Tcp "discord.com" 443
Test-Tcp "gateway.discord.gg" 443
Test-Tcp "cdn.discordapp.com" 443
Write-Host ""

# --- STUN (UDP) ---
Write-Host "=== UDP (STUN) ==="
Write-Host "If STUN FAIL -> Discord Voice often shows 'RTC Connecting'"

$stunServers = @(
    "stun.l.google.com:19302",
    "global.stun.twilio.com:3478"
)

foreach ($s in $stunServers) {
    try {
        $host, $port = $s.Split(":")
        $udp = New-Object System.Net.Sockets.UdpClient
        $udp.Client.ReceiveTimeout = 2000
        $udp.Connect($host, [int]$port)
        $msg = [byte[]](0x00)
        $udp.Send($msg, 1) | Out-Null
        $remote = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any, 0)
        $resp = $udp.Receive([ref]$remote)
        Write-Host "[OK]  UDP STUN $s response from $($remote.Address)" -ForegroundColor Green
        $udp.Close()
    } catch {
        Write-Host "[FAIL] UDP STUN $s" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=== DNS (IPv4) ==="
Get-DnsClientServerAddress -AddressFamily IPv4 |
    Select-Object InterfaceAlias, ServerAddresses

Write-Host ""
Write-Host "=== DONE ==="
