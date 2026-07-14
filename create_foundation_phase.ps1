###############################################################################
# SMOF Kernel
# Foundation Phase
# Create Foundation Package Skeleton
###############################################################################

Clear-Host

Write-Host ""
Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host " SMOF Kernel - Foundation Phase" -ForegroundColor Cyan
Write-Host " Create Foundation Package Skeleton" -ForegroundColor Cyan
Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host ""

# Ensure we are inside a Git repository

if (!(Test-Path ".git")) {
    Write-Host "ERROR: Run this script from the root of SMOF-kernel." -ForegroundColor Red
    exit
}

###############################################################################
# Create directories
###############################################################################

$directories = @(
    "src\smof\foundation",
    "tests\foundation",
    "docs\theory",
    "docs\architecture"
)

foreach ($directory in $directories) {

    if (!(Test-Path $directory)) {

        New-Item `
            -ItemType Directory `
            -Path $directory `
            -Force | Out-Null

        Write-Host "[Created] $directory" -ForegroundColor Green

    }
    else {

        Write-Host "[Exists ] $directory" -ForegroundColor Yellow

    }

}

###############################################################################
# Create source files
###############################################################################

$sourceFiles = @(

    "src\smof\foundation\__init__.py",

    "src\smof\foundation\entity.py",

    "src\smof\foundation\object.py",

    "src\smof\foundation\operator.py",

    "src\smof\foundation\runtime.py"

)

foreach ($file in $sourceFiles) {

    if (!(Test-Path $file)) {

        New-Item `
            -ItemType File `
            -Path $file `
            -Force | Out-Null

        Write-Host "[Created] $file" -ForegroundColor Green

    }
    else {

        Write-Host "[Exists ] $file" -ForegroundColor Yellow

    }

}

###############################################################################
# Create test files
###############################################################################

$testFiles = @(

    "tests\foundation\test_entity.py",

    "tests\foundation\test_object.py",

    "tests\foundation\test_operator.py",

    "tests\foundation\test_runtime.py"

)

foreach ($file in $testFiles) {

    if (!(Test-Path $file)) {

        New-Item `
            -ItemType File `
            -Path $file `
            -Force | Out-Null

        Write-Host "[Created] $file" -ForegroundColor Green

    }
    else {

        Write-Host "[Exists ] $file" -ForegroundColor Yellow

    }

}

###############################################################################
# Create documentation skeleton
###############################################################################

$docs = @(

    "docs\architecture\ADR-0001.md",

    "docs\architecture\ADR-0002.md",

    "docs\theory\KernelTheory.md",

    "docs\theory\FoundationTheory.md",

    "docs\theory\UniversalObjectTheory.md",

    "docs\theory\OperatorTheory.md",

    "docs\theory\RuntimeTheory.md"

)

foreach ($file in $docs) {

    if (!(Test-Path $file)) {

        New-Item `
            -ItemType File `
            -Path $file `
            -Force | Out-Null

        Write-Host "[Created] $file" -ForegroundColor Green

    }
    else {

        Write-Host "[Exists ] $file" -ForegroundColor Yellow

    }

}

###############################################################################
# Summary
###############################################################################

Write-Host ""
Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host " Foundation Package Skeleton Created Successfully" -ForegroundColor Green
Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Next Iteration:" -ForegroundColor Yellow
Write-Host ""
Write-Host "    entity.py" -ForegroundColor White
Write-Host ""
Write-Host "After that:" -ForegroundColor Yellow
Write-Host ""
Write-Host "    object.py" -ForegroundColor White
Write-Host "    operator.py" -ForegroundColor White
Write-Host "    runtime.py" -ForegroundColor White
Write-Host ""