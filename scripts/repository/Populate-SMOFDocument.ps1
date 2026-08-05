<#
===============================================================================
SMOF Repository Infrastructure
-------------------------------------------------------------------------------
Operator ID        : RI-0008
Operator Name      : Populate-SMOFDocument
Classification     : Repository Population Operator
Version            : 1.0
Status             : Draft
Authority          : SMOF Constitution
Repository Layer   : Repository Infrastructure (RI)

Purpose
-------
Populate an existing repository document from its canonical template.

Constitutional Lifecycle
------------------------
Verify
   |
   v
Populate
   |
   v
Validate
   |
   v
Register

===============================================================================
#>
param(

    [Parameter(Mandatory = $true)]
    [string]$Target,

    [switch]$Force

)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================"
Write-Host " Populate-SMOFDocument"
Write-Host "========================================"
Write-Host ""

Write-Host "Target Document"
Write-Host "---------------"
Write-Host $Target
Write-Host ""

if (!(Test-Path $Target))
{
    Write-Host "[FAIL] Target document not found." -ForegroundColor Red
    exit 1
}

Write-Host "[PASS] Target document exists." -ForegroundColor Green

$Template = $Target.Replace("docs\", "templates\docs\")

Write-Host ""
Write-Host "Derived Template"
Write-Host "----------------"
Write-Host $Template

if (!(Test-Path $Template))
{
    Write-Host ""
    Write-Host "[FAIL] Matching template does not exist." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[PASS] Matching template found." -ForegroundColor Green