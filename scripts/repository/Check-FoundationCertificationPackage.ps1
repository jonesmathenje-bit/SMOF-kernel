<#
==============================================================================
SMOF Kernel
Foundation Certification Package Checker

Checks whether the three Foundation Certification Package files exist.

==============================================================================#>

$ErrorActionPreference = "Continue"

Clear-Host

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " SMOF Foundation Certification Package Check"
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

$Files = @(
    "docs\canon\governance\GF-0001-Foundation-Freeze-v1.0.md",
    "docs\canon\governance\FCR-0001-Foundation-Certification-Report.md",
    "scripts\repository\Verify-SMOFRepository.ps1"
)

$Passed = 0
$Failed = 0

foreach ($File in $Files)
{
    if (Test-Path $File)
    {
        $Info = Get-Item $File

        if ($Info.Length -gt 0)
        {
            Write-Host "[PASS] $File" -ForegroundColor Green
            Write-Host "       Size : $($Info.Length) bytes"
            Write-Host "       Date : $($Info.LastWriteTime)"
            Write-Host ""

            $Passed++
        }
        else
        {
            Write-Host "[FAIL] $File exists but is EMPTY." -ForegroundColor Yellow
            Write-Host ""

            $Failed++
        }
    }
    else
    {
        Write-Host "[FAIL] Missing: $File" -ForegroundColor Red
        Write-Host ""

        $Failed++
    }
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " SUMMARY"
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Files Found  : $Passed" -ForegroundColor Green
Write-Host "Files Missing: $Failed" -ForegroundColor Red
Write-Host ""

if ($Failed