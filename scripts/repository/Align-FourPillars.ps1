<#
===============================================================================
SMOF Kernel
Four Pillars Repository Alignment Script

Purpose
-------
Align an existing SMOF Kernel repository with the Four Pillars architecture.

This script is SAFE.

It will:
    ✓ Create missing directories
    ✓ Move existing directories
    ✓ Preserve existing files
    ✓ Never overwrite existing work

===============================================================================
#>

Write-Host ""
Write-Host "========================================="
Write-Host " SMOF Four Pillars Alignment"
Write-Host "========================================="
Write-Host ""

#-------------------------------------------------------
# Verify Repository
#-------------------------------------------------------

if (!(Test-Path ".git")) {
    throw "Current directory is not a Git repository."
}

if (!(Test-Path "src\smof")) {
    throw "SMOF source tree not found."
}

#-------------------------------------------------------
# Ensure docs exists
#-------------------------------------------------------

New-Item -ItemType Directory -Force docs | Out-Null

#-------------------------------------------------------
# Create Four Pillar folders
#-------------------------------------------------------

$pillars = @(
    "docs\smms",
    "docs\canon",
    "docs\bok",
    "docs\kernel"
)

foreach($folder in $pillars){

    if(!(Test-Path $folder)){
        Write-Host "Creating $folder"
        New-Item -ItemType Directory -Force $folder | Out-Null
    }
}

#-------------------------------------------------------
# Move docs\theory -> docs\smms
#-------------------------------------------------------

if(Test-Path "docs\theory"){

    Write-Host "Moving docs\theory -> docs\smms"

    Get-ChildItem "docs\theory" -Force |
        Move-Item -Destination "docs\smms" -Force

    Remove-Item "docs\theory" -Force -Recurse
}

#-------------------------------------------------------
# Create Canon subfolders
#-------------------------------------------------------

$canon = @(
    "docs\canon\architecture",
    "docs\canon\constitution",
    "docs\canon\contracts",
    "docs\canon\adr",
    "docs\canon\certification",
    "docs\canon\ledger",
    "docs\canon\governance",
    "docs\canon\standards"
)

foreach($folder in $canon){

    if(!(Test-Path $folder)){
        Write-Host "Creating $folder"
        New-Item -ItemType Directory -Force $folder | Out-Null
    }
}

#-------------------------------------------------------
# Move docs\architecture
#-------------------------------------------------------

if(Test-Path "docs\architecture"){

    Write-Host "Moving docs\architecture"

    Get-ChildItem "docs\architecture" -Force |
        Move-Item `
            -Destination "docs\canon\architecture" `
            -Force

    Remove-Item "docs\architecture" `
        -Force `
        -Recurse
}

#-------------------------------------------------------
# Create repository scripts folder
#-------------------------------------------------------

New-Item `
    -ItemType Directory `
    -Force `
    "scripts\repository" | Out-Null

#-------------------------------------------------------
# Move Upgrade Script
#-------------------------------------------------------

if(Test-Path "scripts_repository_Upgrade-SMOFKernel.ps1"){

    Write-Host "Moving Upgrade-SMOFKernel.ps1"

    Move-Item `
        "scripts_repository_Upgrade-SMOFKernel.ps1" `
        "scripts\repository\Upgrade-SMOFKernel.ps1" `
        -Force
}

#-------------------------------------------------------
# Create README placeholders
#-------------------------------------------------------

$readmes = @(
    "docs\smms\README.md",
    "docs\canon\README.md",
    "