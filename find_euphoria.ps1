$jsonText = [System.IO.File]::ReadAllText("scratch_symbols.json")
$symbols = $jsonText | ConvertFrom-Json

Write-Host "Total functions in symbols: $($symbols.psobject.Properties.Count)"

# Let's search for recursive functions in Euphoria namespace
$euphoriaFunctions = @()
foreach ($prop in $symbols.psobject.Properties) {
    if ($prop.Value -like "*Euphoria*" -or $prop.Value -like "*Environment*" -or $prop.Value -like "*Selection*") {
        $euphoriaFunctions += [PSCustomObject]@{ Index = $prop.Name; Function = $prop.Value }
    }
}

Write-Host "Found $($euphoriaFunctions.Count) Euphoria functions."
$euphoriaFunctions | Select-Object -First 30 | Format-Table -AutoSize
