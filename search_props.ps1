$jsonText = [System.IO.File]::ReadAllText("scratch_symbols.json")
$symbols = $jsonText | ConvertFrom-Json

Write-Host "Total functions: $($symbols.psobject.Properties.Count)"

# Let's inspect the first 20 and last 20 properties
$allProps = $symbols.psobject.Properties
Write-Host "First 5:"
$allProps | Select-Object -First 5 | ForEach-Object { "$($_.Name): $($_.Value)" }

Write-Host "Searching for ActionToastUI, LeftPanels, SelectionManager, EnvironmentSceneManager, CanvasResponsiveScaler..."
$matched = $allProps | Where-Object { 
    $_.Value -like "*ActionToast*" -or 
    $_.Value -like "*LeftPanels*" -or 
    $_.Value -like "*CanvasResponsiveScaler*" -or
    $_.Value -like "*EnvironmentSceneManager*" -or
    $_.Value -like "*SceneSaveData*"
}

Write-Host "Found $($matched.Count) matches:"
$matched | ForEach-Object { "$($_.Name) -> $($_.Value)" }
