$jsonText = [System.IO.File]::ReadAllText("scratch_symbols.json")
$symbols = $jsonText | ConvertFrom-Json

# Let's search for functions in Euphoria namespace and display their names
$props = $symbols.psobject.Properties | Where-Object { $_.Value -like "*Euphoria*" }

Write-Host "Found $($props.Count) Euphoria functions:"
foreach ($p in $props | Select-Object -First 50) {
    Write-Host "$($p.Name) -> $($p.Value)"
}
