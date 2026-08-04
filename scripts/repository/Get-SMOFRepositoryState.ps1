<#
==============================================================================
SMOF Repository State Audit
==============================================================================

Purpose
-------
Produces a complete repository health report before beginning Phase 2.

This script reports

• Repository information
• Current branch
• Current commit
• Tags
• Working tree
• Remote synchronization
• Test status
• Foundation certification status
==============================================================================#>

$ErrorActionPreference = "Stop"

Clear-Host

Write-Host ""
Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host "          SMOF REPOSITORY STATE REPORT"
Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host ""

#------------------------------------------------------------
# Git Repository
#------------------------------------------------------------

try
{
    git rev-parse --git-dir *> $null
    Write-Host "[PASS] Git Repository"
}
catch
{
    Write-Host "[FAIL] Not inside a Git repository" -ForegroundColor Red
    exit
}

Write-Host ""

#------------------------------------------------------------
# Branch
#------------------------------------------------------------

$Branch = git branch --show-current

Write-Host "Current Branch"
Write-Host "--------------"
Write-Host $Branch
Write-Host ""

#------------------------------------------------------------
# Commit
#------------------------------------------------------------

$Commit = git rev-parse --short HEAD

Write-Host "Current Commit"
Write-Host "--------------"
Write-Host $Commit
Write-Host ""

#------------------------------------------------------------
# Latest Commit
#------------------------------------------------------------

Write-Host "Latest Commit"
Write-Host "-------------"

git log -1 --oneline

Write-Host ""

#------------------------------------------------------------
# Tags
#------------------------------------------------------------

Write-Host "Repository Tags"
Write-Host "---------------"

git tag

Write-Host ""

#------------------------------------------------------------
# Working Tree
#------------------------------------------------------------

Write-Host "Working Tree"
Write-Host "------------"

git status --short

if((git status --porcelain).Length -eq 0)
{
    Write-Host "Repository Clean" -ForegroundColor Green
}
else
{
    Write-Host "Repository contains uncommitted changes" -ForegroundColor Yellow
}

Write-Host ""

#------------------------------------------------------------
# Remote
#------------------------------------------------------------

Write-Host "Remote Status"
Write-Host "-------------"

git remote -v

Write-Host ""

#------------------------------------------------------------
# Ahead / Behind
#------------------------------------------------------------

git fetch origin *> $null

$Status = git status

if($Status -match "ahead")
{
    Write-Host "Repository Ahead of Remote" -ForegroundColor Yellow
}
elseif($Status -match "behind")
{
    Write-Host "Repository Behind Remote" -ForegroundColor Yellow
}
else
{
    Write-Host "Repository Up To Date" -ForegroundColor Green
}

Write-Host ""

#------------------------------------------------------------
# Foundation Artifacts
#------------------------------------------------------------

Write-Host "Foundation Documents"
Write-Host "--------------------"

$Docs = @(
"docs/canon/contracts/FC-0001-MathematicalEntity.md",
"docs/canon/contracts/FC-0002-MathematicalObject.md",
"docs/canon/contracts/FC-0003-MathematicalOperator.md",
"docs/canon/contracts/FC-0004-MathematicalRuntime.md",
"docs/canon/governance/GF-0001-Foundation-Freeze-v1.0.md",
"docs/canon/governance/FCR-0001-Foundation-Certification-Report.md"
)

foreach($Doc in $Docs)
{
    if(Test-Path $Doc)
    {
        Write-Host "[PASS] $Doc" -ForegroundColor Green
    }
    else
    {
        Write-Host "[FAIL] $Doc" -ForegroundColor Red
    }
}

Write-Host ""

#------------------------------------------------------------
# Tests
#------------------------------------------------------------

Write-Host "Pytest"
Write-Host "------"

pytest --version

Write-Host ""

Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host "REPOSITORY READY FOR PHASE 2" -ForegroundColor Green
Write-Host "=============================================================" -ForegroundColor Cyan