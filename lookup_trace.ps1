$jsonText = [System.IO.File]::ReadAllText("scratch_symbols.json")
$symbols = $jsonText | ConvertFrom-Json

$addrs = @(
    "0x2e1caad", "0x2e1cd68", "0x16b46e", "0x198e48", "0x19afd3", 
    "0x1a0885", "0x22c87d4", "0x19910b", "0x1a0349", "0x1a0327", "0x22c87e3"
)

Write-Host "Total symbols: $($symbols.psobject.Properties.Count)"

foreach ($addr in $addrs) {
    $dec = [Convert]::ToInt64($addr, 16)
    $prop = $symbols.psobject.Properties | Where-Object { $_.Name -eq "$dec" }
    if ($prop) {
        Write-Host "$addr ($dec) -> $($prop.Value)"
    } else {
        # Check by hex or index
        Write-Host "$addr ($dec) -> NOT FOUND DIRECTLY"
    }
}
