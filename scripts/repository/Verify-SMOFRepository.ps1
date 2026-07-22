<#
==============================================================================
SMOF Kernel
Repository Constitutional Verification Utility

Identifier:
    Verify-SMOFRepository.ps1

Purpose:
    Performs a complete constitutional audit of the SMOF repository.

Classification:
    Constitutional Verification Utility

Authority:
    GF-0001 Foundation Freeze
    SMOF Constitution

==============================================================================
#>

$ErrorActionPreference = "Stop"

$Passed = 0
$Failed = 0

function Test-Check
{
    param(
        [string]$Name,
        [scriptblock]$Check
    )

    try
    {
        & $Check

        Write-Host ("[PASS] " + $Name) -ForegroundColor Green

        $script:Passed++
    }
    catch
    {
        Write-Host ("[FAIL] " + $Name) -ForegroundColor Red

        $script:Failed++
    }
}

Clear-Host

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " SMOF Repository Constitutional Verification"
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

###########################################################################
# Repository
###########################################################################

Test-Check "Git Repository Exists" {

    if(!(Test-Path ".git"))
    {
        throw
    }

}

###########################################################################
# Branch
###########################################################################

Test-Check "Current Branch is main" {

    $branch = git branch --show-current

    if($branch.Trim() -ne "main")
    {
        throw
    }

}

###########################################################################
# Working Tree
###########################################################################

Test-Check "Working Tree Clean" {

    $status = git status --porcelain

    if($status.Length -gt 0)
    {
        throw
    }

}

###########################################################################
# Remote
###########################################################################

Test-Check "Remote Origin Exists" {

    $remote = git remote

    if($remote -notcontains "origin")
    {
        throw
    }

}

###########################################################################
# Synchronization
###########################################################################

Test-Check "Repository Up To Date" {

    git fetch | Out-Null

    $status = git status | Out-String

    if ($status -notmatch "up to date" -and
        $status -notmatch "up-to-date")
    {
        throw "Repository is not synchronized with origin."
    }

}

###########################################################################
# Canon Directories
###########################################################################

$directories = @(

"docs/canon",

"docs/canon/contracts",

"docs/canon/governance",

"docs/canon/proofs",

"docs/canon/standards",

"src",

"tests",

"scripts"

)

foreach($dir in $directories)
{

    Test-Check "Directory $dir" {

        if(!(Test-Path $dir))
        {
            throw
        }

    }

}

###########################################################################
# Foundation Contracts
###########################################################################

$contracts = @(

"FC-0001",

"FC-0002",

"FC-0003",

"FC-0004"

)

foreach($contract in $contracts)
{

    Test-Check $contract {

        $file = Get-ChildItem docs/canon/contracts -Filter "*$contract*" -ErrorAction SilentlyContinue

        if(!$file)
        {
            throw "$contract contract not found."
        }

    }

}

###########################################################################
# Standards
###########################################################################

$standards = 1..5

foreach($n in $standards)
{
    Test-Check "SCS-000$n" {

        $file = Get-ChildItem docs/canon/standards -Filter "SCS-000$n*" -ErrorAction SilentlyContinue

        if(!$file)
        {
            throw "Standard SCS-000$n not found."
        }

    }

}

###########################################################################
# Foundation Certification Artifacts
###########################################################################

$foundationArtifacts = @(
    "docs/canon/governance/GF-0001-Foundation-Freeze-v1.0.md",
    "docs/canon/governance/FCR-0001-Foundation-Certification-Report.md",
    "scripts/repository/Verify-SMOFRepository.ps1"
)

foreach ($artifact in $foundationArtifacts)
{
    Test-Check "Foundation Artifact: $artifact" {

        if (!(Test-Path $artifact))
        {
            throw "Missing foundation artifact."
        }

        $item = Get-Item $artifact

        if ($item.Length -eq 0)
        {
            throw "Foundation artifact is empty."
        }

    }

}

###########################################################################
# Proof Programme
###########################################################################

Test-Check "Proof Programme Exists" {

    if(!(Test-Path "docs/canon/proofs"))
    {
        throw "Proof Programme directory is missing."
    }

}

###########################################################################
# README
###########################################################################

Test-Check "README Exists" {

    if(!(Test-Path "README.md"))
    {
        throw
    }

}

###########################################################################
# LICENSE
###########################################################################

Test-Check "LICENSE Exists" {

    if(!(Test-Path "LICENSE"))
    {
        throw
    }

}

###########################################################################
# pyproject
###########################################################################

Test-Check "pyproject.toml Exists" {

    if(!(Test-Path "pyproject.toml"))
    {
        throw
    }

}

###########################################################################
# Tests
###########################################################################

Test-Check "Regression Tests" {

    pytest | Out-Null

    if ($LASTEXITCODE -ne 0)
    {
        throw "Regression tests failed."
    }

}
###########################################################################
# Summary
###########################################################################

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Constitutional Verification Summary"
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host ("Passed : " + $Passed) -ForegroundColor Green
Write-Host ("Failed : " + $Failed) -ForegroundColor Red
Write-Host ""

if ($Failed -eq 0)
{
    Write-Host "FOUNDATION STATUS : CERTIFIED" -ForegroundColor Green

    Write-Host ""
    Write-Host "Repository passed all constitutional verification checks." -ForegroundColor Green

    exit 0
}
else
{
    Write-Host "FOUNDATION STATUS : FAILED" -ForegroundColor Red

    Write-Host ""
    Write-Host "Repository failed one or more constitutional verification checks." -ForegroundColor Yellow

    exit 1
}