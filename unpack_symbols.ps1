$gzPath = "Build\Gym Library Build.symbols.json.gz"
$outPath = "scratch_symbols.json"

$fileStream = [System.IO.File]::OpenRead($gzPath)
$gzipStream = New-Object System.IO.Compression.GZipStream($fileStream, [System.IO.Compression.CompressionMode]::Decompress)
$reader = New-Object System.IO.StreamReader($gzipStream)
$content = $reader.ReadToEnd()
$reader.Close()
$gzipStream.Close()
$fileStream.Close()

[System.IO.File]::WriteAllText($outPath, $content)
Write-Host "Unpacked symbols file successfully. Size: $($content.Length)"
