$jsonlPath = "C:\Users\pc\.gemini\antigravity-ide\brain\49afc49e-3813-432a-a10c-4feea6d891e0\.system_generated\logs\transcript.jsonl"
$outPath = "C:\Users\pc\Downloads\Chat_Export_Gym_Library.md"

$lines = Get-Content $jsonlPath -Encoding UTF8
$md = New-Object System.Collections.Generic.List[string]

$md.Add("# 💬 Conversation Transcript: Gym Library WebGL & GitHub LFS Workaround")
$md.Add("")
$md.Add("**Exported Date:** " + (Get-Date).ToString("yyyy-MM-dd HH:mm:ss"))
$md.Add("")
$md.Add("---")
$md.Add("")

foreach ($line in $lines) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    try {
        $entry = $line | ConvertFrom-Json
        if ($entry.type -eq "USER_INPUT" -and $entry.content) {
            $text = $entry.content
            # Strip system tags
            $text = [System.Text.RegularExpressions.Regex]::Replace($text, "<ADDITIONAL_METADATA>[\s\S]*?<\/ADDITIONAL_METADATA>", "")
            $text = [System.Text.RegularExpressions.Regex]::Replace($text, "<USER_SETTINGS_CHANGE>[\s\S]*?<\/USER_SETTINGS_CHANGE>", "")
            $text = [System.Text.RegularExpressions.Regex]::Replace($text, "<\/?USER_REQUEST>", "")
            $text = $text.Trim()
            if ($text.Length -gt 0) {
                $md.Add("## 👤 User")
                $md.Add("")
                $md.Add($text)
                $md.Add("")
                $md.Add("---")
                $md.Add("")
            }
        } elseif ($entry.type -eq "PLANNER_RESPONSE" -and $entry.content) {
            $text = $entry.content.Trim()
            if ($text.Length -gt 0) {
                $md.Add("## 🤖 Assistant")
                $md.Add("")
                $md.Add($text)
                $md.Add("")
                $md.Add("---")
                $md.Add("")
            }
        }
    } catch {}
}

[System.IO.File]::WriteAllLines($outPath, $md, [System.Text.Encoding]::UTF8)
Write-Host "Export completed successfully to: $outPath"
