<#
===============================================================================
SMOF Repository Infrastructure
-------------------------------------------------------------------------------
Operator ID        : RI-0011
Operator Name      : Invoke-RI-0011-RepositoryRecovery
Classification     : Repository Recovery Operator
Version            : 1.0
Status             : Draft
Authority          : SMOF Constitution
Repository Layer   : Repository Infrastructure (RI)

Purpose
-------
Automate the diagnostic, controlled repair, and validation procedure defined
by RI-0011 Repository Recovery Operator.

Design Principle
----------------
Inspect first.
Repair only when a known recoverable reference defect is detected.
Verify after every repair.
Never modify a healthy repository unnecessarily.

PowerShell Compatibility
------------------------
Windows PowerShell 5.1+

===============================================================================
#>

[CmdletBinding()]
param(
    [switch]$Repair,
    [switch]$NoBackup
)

$ErrorActionPreference = "Stop"

$RepositoryRoot = (Get-Location).Path
$GitDirectory    = Join-Path $RepositoryRoot ".git"

$Branch = "release/foundation-v1.0"

$LocalRef = Join-Path `
    $GitDirectory `
    "refs\heads\release\foundation-v1.0"

$RemoteRef = Join-Path `
    $GitDirectory `
    "refs\remotes\origin\release\foundation-v1.0"

$BackupRoot = Join-Path `
    (Split-Path $RepositoryRoot -Parent) `
    "SMOF-Backups"

function Write-Section {
    param([string]$Title)

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host " $Title" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
}

function Test-GitRepository {
    if (-not (Test-Path $GitDirectory)) {
        throw "Not a Git repository: $RepositoryRoot"
    }

    Write-Host "[PASS] Git repository detected." -ForegroundColor Green
}

function Get-RefContent {
    param([string]$Path)

    if (-not (Test-Path $Path)) {
        return $null
    }

    return [System.IO.File]::ReadAllText($Path)
}

function Test-ValidCommitHash {
    param([string]$Value)

    if ($null -eq $Value) {
        return $false
    }

    return $Value -match '^[0-9a-fA-F]{40}$'
}

function Write-GitRefLF {
    param(
        [string]$Path,
        [string]$Commit
    )

    $Bytes = [System.Text.Encoding]::ASCII.GetBytes(
        $Commit + "`n"
    )

    [System.IO.File]::WriteAllBytes($Path, $Bytes)
}

function Backup-Reference {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (Test-Path $Source) {
        Copy-Item $Source $Destination -Force
        Write-Host "[PASS] Reference backed up: $Destination" `
            -ForegroundColor Green
    }
}

Write-Section "RI-0011 REPOSITORY RECOVERY"

Write-Host "Repository : $RepositoryRoot"
Write-Host "Branch     : $Branch"
Write-Host "Mode       : $(if ($Repair) { 'REPAIR' } else { 'DIAGNOSTIC' })"

Write-Section "1. REPOSITORY INSPECTION"

Test-GitRepository

$CurrentBranch = git branch --show-current

if ($CurrentBranch -ne $Branch) {
    Write-Host "[WARN] Current branch is '$CurrentBranch'." `
        -ForegroundColor Yellow
    Write-Host "[WARN] Expected branch is '$Branch'." `
        -ForegroundColor Yellow
}
else {
    Write-Host "[PASS] Expected branch detected." `
        -ForegroundColor Green
}

$Head = git rev-parse HEAD

if (Test-ValidCommitHash $Head) {
    Write-Host "[PASS] HEAD resolves to commit $Head" `
        -ForegroundColor Green
}
else {
    throw "HEAD does not resolve to a valid commit."
}

Write-Section "2. REFERENCE INSPECTION"

$LocalContent  = Get-RefContent $LocalRef
$RemoteContent = Get-RefContent $RemoteRef

Write-Host "Local reference:"
Write-Host $LocalContent

Write-Host ""
Write-Host "Remote-tracking reference:"
Write-Host $RemoteContent

$LocalHash = if ($LocalContent) {
    $LocalContent.Trim()
}
else {
    $null
}

$RemoteHash = if ($RemoteContent) {
    $RemoteContent.Trim()
}
else {
    $null
}

$LocalValid  = Test-ValidCommitHash $LocalHash
$RemoteValid = Test-ValidCommitHash $RemoteHash

if ($LocalValid) {
    Write-Host "[PASS] Local reference contains a valid commit hash." `
        -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Local reference is malformed." `
        -ForegroundColor Red
}

if ($RemoteValid) {
    Write-Host "[PASS] Remote-tracking reference contains a valid commit hash." `
        -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Remote-tracking reference is malformed." `
        -ForegroundColor Red
}

Write-Section "3. OBJECT VALIDATION"

$HeadType = git cat-file -t $Head 2>$null

if ($HeadType -eq "commit") {
    Write-Host "[PASS] HEAD object is a commit." `
        -ForegroundColor Green
}
else {
    throw "HEAD object is not a valid commit."
}

Write-Section "4. GIT INTEGRITY"

git fsck --full

Write-Host "[PASS] Git object/reference inspection completed." `
    -ForegroundColor Green

$NeedsRepair = $false

if (-not $LocalValid -or -not $RemoteValid) {
    $NeedsRepair = $true
}

if ($LocalValid -and $RemoteValid -and ($LocalHash -ne $RemoteHash)) {
    Write-Host "[WARN] Local and remote-tracking references differ." `
        -ForegroundColor Yellow
}

if (-not $NeedsRepair) {
    Write-Host ""
    Write-Host "[PASS] No malformed reference detected." `
        -ForegroundColor Green
}

if ($NeedsRepair -and -not $Repair) {

    Write-Section "RECOVERY REQUIRED"

    Write-Host "[WARN] A recoverable reference defect was detected." `
        -ForegroundColor Yellow

    Write-Host ""
    Write-Host "No changes were made."
    Write-Host ""
    Write-Host "To perform controlled recovery, rerun with:"
    Write-Host ""
    Write-Host ".\scripts\repository\Invoke-RI-0011-RepositoryRecovery.ps1 -Repair" `
        -ForegroundColor Yellow

    exit 2
}

if ($NeedsRepair -and $Repair) {

    Write-Section "5. CONTROLLED RECOVERY"

    if (-not $NoBackup) {

        $Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

        $RecoveryBackup = Join-Path `
            $BackupRoot `
            "RI-0011-Recovery-$Timestamp"

        New-Item `
            -ItemType Directory `
            -Path $RecoveryBackup `
            -Force | Out-Null

        Write-Host "[PASS] Recovery backup directory created:" `
            -ForegroundColor Green

        Write-Host $RecoveryBackup

        Backup-Reference `
            $LocalRef `
            (Join-Path $RecoveryBackup "local-release-foundation-v1.0.ref")

        Backup-Reference `
            $RemoteRef `
            (Join-Path $RecoveryBackup "origin-release-foundation-v1.0.ref")
    }

    Write-Host ""
    Write-Host "Repairing references using LF line endings..." `
        -ForegroundColor Yellow

    Write-GitRefLF `
        $LocalRef `
        $Head

    Write-GitRefLF `
        $RemoteRef `
        $Head

    Write-Host "[PASS] References rewritten with LF termination." `
        -ForegroundColor Green
}

Write-Section "6. POST-RECOVERY VALIDATION"

$PostLocal  = Get-RefContent $LocalRef
$PostRemote = Get-RefContent $RemoteRef

$PostLocalHash  = $PostLocal.Trim()
$PostRemoteHash = $PostRemote.Trim()

if ($PostLocalHash -eq $Head) {
    Write-Host "[PASS] Local reference matches HEAD." `
        -ForegroundColor Green
}
else {
    throw "Local reference does not match HEAD."
}

if ($PostRemoteHash -eq $Head) {
    Write-Host "[PASS] Remote-tracking reference matches HEAD." `
        -ForegroundColor Green
}
else {
    throw "Remote-tracking reference does not match HEAD."
}

Write-Host ""
Write-Host "Running final Git integrity check..." `
    -ForegroundColor Yellow

git fsck --full

Write-Section "7. FINAL REPOSITORY STATE"

git status

Write-Host ""
Write-Host "Branch:"
git branch --show-current

Write-Host ""
Write-Host "HEAD:"
git rev-parse HEAD

Write-Host ""
Write-Host "Upstream:"
git rev-parse --abbrev-ref --symbolic-full-name '@{u}'

Write-Section "RI-0011 RESULT"

Write-Host "[PASS] RI-0011 repository recovery procedure completed." `
    -ForegroundColor Green

Write-Host ""
Write-Host "No automatic commit or push was performed."
Write-Host "Repository registration remains a separate controlled operation."
