# ===============================
# Amnezia Split Routing - ON
# ===============================

$ErrorActionPreference = "SilentlyContinue"

$BASE_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$DOMAINS_FILE = Join-Path $BASE_DIR "domains.txt"
$METRIC = 1337

# --- Find WireGuard / Amnezia adapter ---
$wg = Get-NetAdapter |
    Where-Object {
        $_.Status -eq "Up" -and (
            $_.InterfaceDescription -match "WireGuard" -or
            $_.Name -match "WARP" -or
            $_.Name -match "Amnezia"
        )
    } |
    Select-Object -First 1

if (-not $wg) {
    Write-Host "[ERROR] Amnezia/WireGuard adapter not found or not up"
    exit 1
}

$ifIndex = $wg.ifIndex
Write-Host "[OK] Using adapter: $($wg.Name) (ifIndex=$ifIndex)"

# --- Read domains ---
if (-not (Test-Path $DOMAINS_FILE)) {
    Write-Host "[ERROR] domains.txt not found"
    exit 1
}

$domains = Get-Content $DOMAINS_FILE |
    ForEach-Object { $_.Trim() } |
    Where-Object { $_ -and -not $_.StartsWith("#") }

# --- Add routes ---
foreach ($domain in $domains) {
    try {
        $ips = Resolve-DnsName $domain -Type A -ErrorAction Stop |
            Select-Object -ExpandProperty IPAddress

        foreach ($ip in $ips) {
            if (-not (Get-NetRoute -DestinationPrefix "$ip/32" -ErrorAction SilentlyContinue)) {
                New-NetRoute `
                    -DestinationPrefix "$ip/32" `
                    -InterfaceIndex $ifIndex `
                    -NextHop "0.0.0.0" `
                    -RouteMetric $METRIC `
                    -PolicyStore ActiveStore | Out-Null
            }
        }
    } catch {
        Write-Host "[WARN] DNS resolve failed: $domain"
    }
}

Write-Host "[DONE] Split routing enabled"
