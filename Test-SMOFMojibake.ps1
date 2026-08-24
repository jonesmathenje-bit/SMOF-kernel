Write-Host "========================================" -ForegroundColor Cyan
Write-Host " SMOF MOJIBAKE DETECTION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$Root = (Get-Location).Path

$Patterns = @(
    'â”',
    'â“',
    'âœ',
    'â',
    'â™',
    'â¦',
    'Â',
    'Ã'
)

$Files = Get-ChildItem -LiteralPath $Root -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object {
        $_.FullName -notmatch '\\\.git\\' -and
        $_.FullName -notmatch '\\\.venv\\' -and
        $_.FullName -ne (Join-Path $Root 'Test-SMOFMojibake.ps1') -and
        $_.Extension -in '.md','.txt','.ps1','.py','.json','.yml','.yaml','.toml'
    }

$Hits = foreach ($File in $Files) {
    $LineNumber = 0

    foreach ($Line in [System.IO.File]::ReadLines($File.FullName)) {
        $LineNumber++

        foreach ($Pattern in $Patterns) {
            if ($Line.Contains($Pattern)) {
                [PSCustomObject]@{
                    Path       = $File.FullName
                    LineNumber = $LineNumber
                    Pattern    = $Pattern
                    Line       = $Line
                }
                break
            }
        }
    }
}

Write-Host "Files scanned : $($Files.Count)" -ForegroundColor Cyan
Write-Host ""

if (-not $Hits) {
    Write-Host "[PASS] No known mojibake markers detected outside .git and .venv." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Mojibake detected: $($Hits.Count) occurrence(s)." -ForegroundColor Red
    Write-Host ""
    $Hits | Format-Table -AutoSize -Wrap
}
