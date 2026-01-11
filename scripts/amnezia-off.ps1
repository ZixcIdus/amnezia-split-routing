# ===============================
# Amnezia Split Routing - OFF
# ===============================

$METRIC = 1337

Get-NetRoute |
    Where-Object { $_.RouteMetric -eq $METRIC } |
    ForEach-Object {
        Remove-NetRoute `
            -DestinationPrefix $_.DestinationPrefix `
            -InterfaceIndex $_.InterfaceIndex `
            -PolicyStore ActiveStore `
            -Confirm:$false
    }

Write-Host "[DONE] Split routing disabled"
