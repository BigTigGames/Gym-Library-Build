@echo off
echo ========================================================
echo   Auto-Splitting Large Build Files for GitHub
echo ========================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$file = 'Build\Gym Library Build.data.gz';" ^
    "if (-not (Test-Path $file)) { Write-Host '[ERROR] File not found: ' $file -ForegroundColor Red; exit 1; }" ^
    "$bytes = [System.IO.File]::ReadAllBytes($file);" ^
    "$chunkSize = 45MB;" ^
    "$part = 1;" ^
    "for ($i = 0; $i -lt $bytes.Length; $i += $chunkSize) {" ^
    "  $count = [Math]::Min($chunkSize, $bytes.Length - $i);" ^
    "  $partPath = \"$file.part$part\";" ^
    "  [System.IO.File]::WriteAllBytes($partPath, $bytes[$i..($i + $count - 1)]);" ^
    "  Write-Host \"Created: $partPath ($([Math]::Round($count / 1MB, 2)) MB)\" -ForegroundColor Green;" ^
    "  $part++;" ^
    "};" ^
    "Write-Host '[SUCCESS] All parts created successfully!' -ForegroundColor Cyan;"

echo.
echo ========================================================
pause
