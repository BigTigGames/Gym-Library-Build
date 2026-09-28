$jsonText = [System.IO.File]::ReadAllText("scratch_symbols.json")
$symbols = $jsonText | ConvertFrom-Json

$addresses = @("0x1521d2", "0x236cceb", "0x236cf2a", "0x165bf5", "0x1934a5", "0x195630", "0x19aee2", "0x1824135", "0x193768")

Write-Host "Looking up addresses..."
if ($symbols -is [System.Collections.IDictionary] -or $symbols.psobject.Properties) {
    foreach ($addr in $addresses) {
        $dec = [Convert]::ToInt32($addr, 16)
        Write-Host "Address $addr (dec $dec):"
        # Search by key or property
        if ($symbols.$addr) {
            Write-Host "  Direct key match: $($symbols.$addr)"
        } elseif ($symbols."$dec") {
            Write-Host "  Dec key match: $($symbols."$dec")"
        }
    }
}
