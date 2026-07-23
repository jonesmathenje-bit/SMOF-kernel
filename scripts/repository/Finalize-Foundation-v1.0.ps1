<#

SMOF Foundation Certification Finalizer
Version : 1.1.0
===============

## Purpose

Finalizes the SMOF Foundation Certification package by:

• Scanning every Markdown file under docs/
• Creating a .bak backup before modification
• Replacing *TODO* placeholders
• Updating Status from Draft to Certified
• Updating Last Updated to today
• Normalizing common mojibake encoding artifacts
• Saving all files as UTF-8 without BOM
• Verifying required governance documents
• Producing a certification summary
• Returning:
0 = Success
1 = Warnings remain

Recommended location:
scripts/repository/Finalize-FoundationCertification.ps1
==============================================================================
#>

[CmdletBinding()]
param(
[string]$RepositoryRoot = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'

try {
$Today = Get-Date -Format 'yyyy-MM-dd'

```
$Warnings  = New-Object System.Collections.Generic.List[string]
$Processed = 0
$Modified  = 0

#----------------------------------------------------------
# Repository Paths
#----------------------------------------------------------

$Docs = Join-Path $RepositoryRoot 'docs'

$Governance = @(
    'docs\canon\governance\GF-0001-Foundation-Freeze-v1.0.md',
    'docs\canon\governance\FCR-0001-Foundation-Certification-Report.md'
)

if (-not (Test-Path $Docs)) {
    Write-Error 'docs directory not found.'
    exit 1
}

#----------------------------------------------------------
# UTF-8 (without BOM)
#----------------------------------------------------------

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

#----------------------------------------------------------
# Encoding normalization map
#----------------------------------------------------------

$EncodingMap = @{
    'â€”' = '—'
    'â€“' = '–'
    'â€œ' = '“'
    'â€' = '”'
    'â€™' = '’'
    'â€¦' = '…'
}

#----------------------------------------------------------
# Process Markdown Files
#----------------------------------------------------------

$Files = Get-ChildItem `
    -Path $Docs `
    -Filter *.md `
    -Recurse `
    -File

foreach ($File in $Files) {

    $Processed++

    Write-Host ('Processing {0}' -f $File.FullName)

    #--------------------------------------
    # Backup
    #--------------------------------------

    $Backup = '{0}.bak' -f $File.FullName

    if (-not (Test-Path $Backup)) {
        Copy-Item $File.FullName $Backup -Force
    }

    #--------------------------------------
    # Read as UTF-8
    #--------------------------------------

    $Content = [System.IO.File]::ReadAllText(
        $File.FullName,
        [System.Text.Encoding]::UTF8
    )

    $Original = $Content

    #--------------------------------------
    # Normalize encoding artifacts
    #--------------------------------------

    foreach ($pair in $EncodingMap.GetEnumerator()) {
        $Content = $Content.Replace($pair.Key, $pair.Value)
    }

    #--------------------------------------
    # Replace TODO placeholders
    #--------------------------------------

    $Content = $Content.Replace(
        '_TODO_',
        '**REVIEW REQUIRED**'
    )

    #--------------------------------------
    # Status: Draft -> Certified
    #--------------------------------------

    $Content = [regex]::Replace(
        $Content,
        '(?m)^\|\s*Status\s*\|\s*Draft\s*\|$',
        '| Status | Certified |'
    )

    #--------------------------------------
    # Last Updated -> today
    #--------------------------------------

    $Content = [regex]::Replace(
        $Content,
        '(?m)^\|\s*Last Updated\s*\|.*\|$',
        '| Last Updated | ' + $Today + ' |'
    )

    #--------------------------------------
    # Save if changed
    #--------------------------------------

    if ($Content -ne $Original) {

        [System.IO.File]::WriteAllText(
            $File.FullName,
            $Content,
            $Utf8NoBom
        )

        $Modified++
    }

    #--------------------------------------
    # Validation checks
    #--------------------------------------

    if ($Content -match '_TODO_') {
        $Warnings.Add(
            ('{0}: contains _TODO_' -f $File.Name)
        )
    }

    if ($Content -match '(?m)^\|\s*Status\s*\|\s*Draft') {
        $Warnings.Add(
            ('{0}: Status still Draft' -f $File.Name)
        )
    }

    if ($Content -match '(?m)^\$1') {
        $Warnings.Add(
            ('{0}: malformed Last Updated row' -f $File.Name)
        )
    }

    if ($Content -match 'â€”|â€“|â€œ|â€|â€™|â€¦') {
        $Warnings.Add(
            ('{0}: encoding artifacts remain' -f $File.Name)
        )
    }
}

#----------------------------------------------------------
# Governance Verification
#----------------------------------------------------------

Write-Host ''
Write-Host 'Checking Governance Documents...'

foreach ($Doc in $Governance) {

    $Path = Join-Path $RepositoryRoot $Doc

    if (Test-Path $Path) {
        Write-Host ('PASS  {0}' -f $Doc) -ForegroundColor Green
    }
    else {
        Write-Host ('FAIL  {0}' -f $Doc) -ForegroundColor Red
        $Warnings.Add($Doc)
    }
}

#----------------------------------------------------------
# Summary
#----------------------------------------------------------

Write-Host ''
Write-Host '=============================================' -ForegroundColor Cyan
Write-Host ' FOUNDATION CERTIFICATION SUMMARY' -ForegroundColor Cyan
Write-Host '=============================================' -ForegroundColor Cyan
Write-Host ''

Write-Host ('Markdown Files : {0}' -f $Processed)
Write-Host ('Modified Files : {0}' -f $Modified)
Write-Host ('Warnings       : {0}' -f $Warnings.Count)

if ($Warnings.Count -eq 0) {

    Write-Host ''
    Write-Host 'FOUNDATION CERTIFICATION PASSED' -ForegroundColor Green

    exit 0
}
else {

    Write-Host ''
    Write-Host 'FOUNDATION CERTIFICATION HAS WARNINGS' -ForegroundColor Yellow
    Write-Host ''

    $Warnings |
        Sort-Object -Unique |
        ForEach-Object {
            Write-Host (' - {0}' -f $_) -ForegroundColor Yellow
        }

    exit 1
}
```

}
catch {

```
Write-Host ''
Write-Host '=============================================' -ForegroundColor Red
Write-Host ' FOUNDATION CERTIFICATION FAILED' -ForegroundColor Red
Write-Host '=============================================' -ForegroundColor Red
Write-Host ''

Write-Host $_.Exception.Message -ForegroundColor Red

exit 1
```

}
