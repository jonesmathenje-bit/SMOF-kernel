$ErrorActionPreference = "Stop"

$Repo = "C:\Users\BONOLO RAMOLLO\Documents\SMOF\smof-kernel"
$BranchExpected = "release/foundation-v1.0"
$Generator = Join-Path $Repo "scripts\repository\Create-PM0007.ps1"

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " SMOF PM-0007 GENERATOR LINE-ENDINGS REPAIR" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------
# Repository contract
# ------------------------------------------------

if (-not (Test-Path (Join-Path $Repo ".git"))) {
    throw "Not a Git repository: $Repo"
}

if (-not (Test-Path $Generator)) {
    throw "Generator not found: $Generator"
}

Set-Location $Repo

$Branch = (git branch --show-current).Trim()

if ($Branch -ne $BranchExpected) {
    throw "Expected branch $BranchExpected, detected $Branch"
}

Write-Host "[PASS] Repository detected." -ForegroundColor Green
Write-Host "[PASS] Branch: $Branch" -ForegroundColor Green
Write-Host "[PASS] Generator detected." -ForegroundColor Green
Write-Host ""

# ------------------------------------------------
# Read generator
# ------------------------------------------------

$GeneratorPath = (Resolve-Path $Generator).Path

$ScriptText = [System.IO.File]::ReadAllText(
    $GeneratorPath,
    $Utf8NoBom
)

if ([string]::IsNullOrWhiteSpace($ScriptText)) {
    throw "Generator is empty."
}

# ------------------------------------------------
# Split generator into physical lines
# ------------------------------------------------

$Lines = $ScriptText -split "`r?`n"

# ------------------------------------------------
# Locate exact PM-0007 here-string opening
# ------------------------------------------------

$OpeningIndexes = @()

for ($i = 0; $i -lt $Lines.Count; $i++) {
    if ($Lines[$i].TrimEnd() -eq '$Content = @''') {
        $OpeningIndexes += $i
    }
}

if ($OpeningIndexes.Count -ne 1) {
    throw "Expected exactly one '$Content = @''' opening; found $($OpeningIndexes.Count)."
}

$OpeningIndex = $OpeningIndexes[0]

Write-Host "[PASS] PM-0007 here-string opening located at line $($OpeningIndex + 1)." -ForegroundColor Green

# ------------------------------------------------
# Locate standalone here-string terminator
# ------------------------------------------------

$ClosingIndexes = @()

for ($i = $OpeningIndex + 1; $i -lt $Lines.Count; $i++) {
    if ($Lines[$i].TrimEnd() -eq "'@") {
        $ClosingIndexes += $i
    }
}

if ($ClosingIndexes.Count -ne 1) {
    throw "Expected exactly one standalone PM-0007 here-string terminator after the opening; found $($ClosingIndexes.Count)."
}

$ClosingIndex = $ClosingIndexes[0]

Write-Host "[PASS] PM-0007 here-string terminator located at line $($ClosingIndex + 1)." -ForegroundColor Green

if ($ClosingIndex -le $OpeningIndex) {
    throw "Invalid here-string structure."
}

# ------------------------------------------------
# Extract embedded PM-0007
# ------------------------------------------------

$EmbeddedLines = @()

if ($ClosingIndex -gt ($OpeningIndex + 1)) {
    $EmbeddedLines = $Lines[
        ($OpeningIndex + 1)..($ClosingIndex - 1)
    ]
}

# ------------------------------------------------
# Normalize embedded PM-0007
# ------------------------------------------------

$NormalizedEmbedded = ($EmbeddedLines -join "`n")

$NormalizedEmbedded = $NormalizedEmbedded.TrimEnd("`n")

$NormalizedEmbeddedLines = $NormalizedEmbedded -split "`n"

Write-Host "[PASS] Embedded PM-0007 content normalized to LF-only." -ForegroundColor Green

# ------------------------------------------------
# Reconstruct generator
# ------------------------------------------------

$PrefixLines = @()

if ($OpeningIndex -ge 0) {
    $PrefixLines = $Lines[0..$OpeningIndex]
}

$SuffixLines = @()

if ($ClosingIndex -lt ($Lines.Count - 1)) {
    $SuffixLines = $Lines[
        ($ClosingIndex + 1)..($Lines.Count - 1)
    ]
}

$RebuiltLines = @()

$RebuiltLines += $PrefixLines
$RebuiltLines += $NormalizedEmbeddedLines
$RebuiltLines += "'@"
$RebuiltLines += $SuffixLines

$Rebuilt = $RebuiltLines -join "`n"

# ------------------------------------------------
# Normalize generator globally
# ------------------------------------------------

$Rebuilt = $Rebuilt.Replace("`r`n", "`n")
$Rebuilt = $Rebuilt.Replace("`r", "`n")
$Rebuilt = $Rebuilt.TrimEnd("`n") + "`n"

# ------------------------------------------------
# Write UTF-8 without BOM
# ------------------------------------------------

[System.IO.File]::WriteAllText(
    $GeneratorPath,
    $Rebuilt,
    $Utf8NoBom
)

Write-Host "[PASS] Create-PM0007.ps1 rewritten with LF-only content." -ForegroundColor Green

# ------------------------------------------------
# Encoding verification
# ------------------------------------------------

$VerifyBytes = [System.IO.File]::ReadAllBytes($GeneratorPath)

$VerifyText = [System.IO.File]::ReadAllText(
    $GeneratorPath,
    $Utf8NoBom
)

$HasBom = $false

if ($VerifyBytes.Length -ge 3) {
    $HasBom = (
        $VerifyBytes[0] -eq 0xEF -and
        $VerifyBytes[1] -eq 0xBB -and
        $VerifyBytes[2] -eq 0xBF
    )
}

$HasCR = $VerifyText.Contains("`r")
$HasFinalLF = $VerifyText.EndsWith("`n")
$HasDoubleFinalLF = $VerifyText.EndsWith("`n`n")

if ($HasBom) {
    throw "Repair failed: generator contains UTF-8 BOM."
}

if ($HasCR) {
    throw "Repair failed: generator contains CR characters."
}

if (-not $HasFinalLF) {
    throw "Repair failed: generator does not end with LF."
}

if ($HasDoubleFinalLF) {
    throw "Repair failed: generator contains multiple final LF characters."
}

Write-Host "[PASS] Generator UTF-8 BOM absent." -ForegroundColor Green
Write-Host "[PASS] Generator LF-only." -ForegroundColor Green
Write-Host "[PASS] Generator has exactly one final LF." -ForegroundColor Green

# ------------------------------------------------
# Here-string structural verification
# ------------------------------------------------

$VerifyLines = $VerifyText -split "`n"

$VerifyOpeningCount = @(
    $VerifyLines |
        Where-Object {
            $_.TrimEnd() -eq '$Content = @'''
        }
).Count

$VerifyClosingCount = @(
    $VerifyLines |
        Where-Object {
            $_.TrimEnd() -eq "'@"
        }
).Count

if ($VerifyOpeningCount -ne 1) {
    throw "Expected exactly one PM-0007 here-string opening; found $VerifyOpeningCount."
}

if ($VerifyClosingCount -ne 1) {
    throw "Expected exactly one standalone here-string terminator; found $VerifyClosingCount."
}

Write-Host "[PASS] PM-0007 here-string structure preserved." -ForegroundColor Green

# ------------------------------------------------
# PowerShell parser audit
# ------------------------------------------------

$Errors = @()

[System.Management.Automation.Language.Parser]::ParseFile(
    $GeneratorPath,
    [ref]$null,
    [ref]$Errors
) | Out-Null

if ($Errors.Count -ne 0) {
    Write-Host ""
    Write-Host "--- PARSER ERRORS ---" -ForegroundColor Red

    foreach ($ErrorRecord in $Errors) {
        Write-Host $ErrorRecord.ToString() -ForegroundColor Red
    }

    throw "Create-PM0007.ps1 parser audit failed."
}

Write-Host "[PASS] Create-PM0007.ps1 parses successfully." -ForegroundColor Green

# ------------------------------------------------
# Required generator phases
# ------------------------------------------------

$RequiredMarkers = @(
    "# Canonical artifact",
    "# Normalize and write canonical artifact",
    "# Encoding audit",
    "# Canonical section audit",
    "# Dependency audit",
    "# Protected artifact integrity",
    "# Git diff check",
    "# Final artifact report"
)

foreach ($Marker in $RequiredMarkers) {
    if (-not $VerifyText.Contains($Marker)) {
        throw "Required generator phase missing: $Marker"
    }
}

Write-Host "[PASS] All PM-0007 generator phases preserved." -ForegroundColor Green

# ------------------------------------------------
# Required PM-0007 mathematical structures
# ------------------------------------------------

$RequiredMath = @(
    "# PM-0007 - Data Mathematics",
    "\mathcal{D}",
    "\mathcal{S}_D",
    "I_D",
    "T_D",
    "P_D",
    "\mathcal{L}_D",
    "\delta_D",
    "\Theta_D",
    "\oplus_D"
)

foreach ($Marker in $RequiredMath) {
    if (-not $VerifyText.Contains($Marker)) {
        throw "Required PM-0007 mathematical structure missing: $Marker"
    }
}

Write-Host "[PASS] Required PM-0007 mathematical structures preserved." -ForegroundColor Green

# ------------------------------------------------
# Git diff check
# ------------------------------------------------

git diff --check

if ($LASTEXITCODE -ne 0) {
    throw "git diff --check failed."
}

Write-Host "[PASS] git diff --check is clean." -ForegroundColor Green

# ------------------------------------------------
# Final report
# ------------------------------------------------

Write-Host ""
Write-Host "--- REPAIRED GENERATOR ---" -ForegroundColor Yellow

Get-Item $Generator |
    Select-Object FullName, Length

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " PM-0007 GENERATOR REPAIR COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next controlled step:" -ForegroundColor White
Write-Host "Run Create-PM0007.ps1 and inspect the complete canonical audit." -ForegroundColor White
