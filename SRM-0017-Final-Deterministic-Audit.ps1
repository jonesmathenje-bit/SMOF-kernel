$ErrorActionPreference = "Stop"

$path = ".\docs\canon\srm\SRM-0017-Transition-Error-and-Residual-Mathematics.md"
$pass = $true

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " SRM-0017 FINAL DETERMINISTIC AUDIT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# ------------------------------------------------------------
# 1. FILE EXISTENCE
# ------------------------------------------------------------

Write-Host ""
Write-Host "1. File existence" -ForegroundColor Yellow

if (Test-Path -LiteralPath $path -PathType Leaf) {
    Write-Host "[PASS] File exists." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] File missing." -ForegroundColor Red
    $pass = $false
}

if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host " SRM-0017 AUDIT ABORTED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    exit 1
}

# ------------------------------------------------------------
# 2. READ FILE
# ------------------------------------------------------------

$lines = Get-Content -LiteralPath $path
$text  = [System.IO.File]::ReadAllText(
    (Resolve-Path -LiteralPath $path).Path
)

# ------------------------------------------------------------
# 3. CANONICAL TITLE
# ------------------------------------------------------------

Write-Host ""
Write-Host "2. Canonical title" -ForegroundColor Yellow

$emDash = [char]0x2014
$expectedTitle = "# SRM-0017 $emDash Transition Error and Residual Mathematics"
$firstLine = $lines[0]

Write-Host "Expected: [$expectedTitle]"
Write-Host "Actual  : [$firstLine]"

if ($firstLine -ceq $expectedTitle) {
    Write-Host "[PASS] Canonical title is correct." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Canonical title mismatch." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 4. EXPLICIT U+2014 CHECK
# ------------------------------------------------------------

Write-Host ""
Write-Host "3. U+2014 em dash encoding" -ForegroundColor Yellow

$emDashCount = 0

foreach ($character in $firstLine.ToCharArray()) {
    if ([int][char]$character -eq 0x2014) {
        $emDashCount++
    }
}

Write-Host "U+2014 count in title: $emDashCount"

if ($emDashCount -eq 1) {
    Write-Host "[PASS] Exactly one U+2014 em dash confirmed." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Expected exactly one U+2014 em dash." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 5. GIT CONFLICT MARKERS
# ------------------------------------------------------------

Write-Host ""
Write-Host "4. Git conflict markers" -ForegroundColor Yellow

$conflicts = Select-String `
    -LiteralPath $path `
    -Pattern '^(<<<<<<<|=======|>>>>>>>)(.*)$'

if ($null -eq $conflicts) {
    Write-Host "[PASS] No Git conflict markers." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Git conflict markers detected." -ForegroundColor Red
    $conflicts
    $pass = $false
}

# ------------------------------------------------------------
# 6. STANDALONE REPEATED EQUALS
# ------------------------------------------------------------

Write-Host ""
Write-Host "5. Standalone repeated '=' lines" -ForegroundColor Yellow

$standalone = Select-String `
    -LiteralPath $path `
    -Pattern '^={3,}$'

if ($null -eq $standalone) {
    Write-Host "[PASS] No standalone repeated '=' lines." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Standalone repeated '=' lines detected." -ForegroundColor Red
    $standalone
    $pass = $false
}

# ------------------------------------------------------------
# 7. TRAILING WHITESPACE
# ------------------------------------------------------------

Write-Host ""
Write-Host "6. Trailing whitespace" -ForegroundColor Yellow

$trailing = Select-String `
    -LiteralPath $path `
    -Pattern '[ \t]+$'

if ($null -eq $trailing) {
    Write-Host "[PASS] No trailing whitespace." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Trailing whitespace detected." -ForegroundColor Red
    $trailing
    $pass = $false
}

# ------------------------------------------------------------
# 8. POINTWISE ERROR
# ------------------------------------------------------------

Write-Host ""
Write-Host "7. Pointwise error mathematics" -ForegroundColor Yellow

$errorPointwise = 'e_k=x_k-x^\ast'

if ($text.Contains($errorPointwise)) {
    Write-Host "[PASS] Pointwise error definition found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Pointwise error definition missing." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 9. METRIC ERROR
# ------------------------------------------------------------

Write-Host ""
Write-Host "8. Metric error mathematics" -ForegroundColor Yellow

$errorMetric = 'E_k=d(x_k,x^\ast)'

if ($text.Contains($errorMetric)) {
    Write-Host "[PASS] Metric error definition found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Metric error definition missing." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 10. TRANSITION EQUATION
# ------------------------------------------------------------

Write-Host ""
Write-Host "9. State transition mathematics" -ForegroundColor Yellow

$transition = 'x_{k+1}=T(x_k)'

if ($text.Contains($transition)) {
    Write-Host "[PASS] State transition equation found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] State transition equation missing." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 11. TIME-VARYING TRANSITION
# ------------------------------------------------------------

Write-Host ""
Write-Host "10. Time-varying transition mathematics" -ForegroundColor Yellow

$transitionVariable = 'x_{k+1}=T_k(x_k)'

if ($text.Contains($transitionVariable)) {
    Write-Host "[PASS] Time-varying transition equation found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Time-varying transition equation missing." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 12. TRANSITION RESIDUAL
# ------------------------------------------------------------

Write-Host ""
Write-Host "11. Transition residual mathematics" -ForegroundColor Yellow

$residual = 'R_k=d(x_{k+1},T(x_k))'

if ($text.Contains($residual)) {
    Write-Host "[PASS] Transition residual definition found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Transition residual definition missing." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 13. LIMIT
# ------------------------------------------------------------

Write-Host ""
Write-Host "12. Limit mathematics" -ForegroundColor Yellow

if ($text.Contains('\lim')) {
    Write-Host "[PASS] Limit notation found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Limit notation missing." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 14. RESIDUAL CONVERGENCE
# ------------------------------------------------------------

Write-Host ""
Write-Host "13. Residual convergence" -ForegroundColor Yellow

if ($text.Contains('R_k\to0')) {
    Write-Host "[PASS] Residual convergence notation found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Residual convergence notation missing." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 15. ERROR CONVERGENCE
# ------------------------------------------------------------

Write-Host ""
Write-Host "14. Error convergence" -ForegroundColor Yellow

$errorConvergence1 = 'E_k\to0'
$errorConvergence2 = '\limsup_{k\to\infty}E_k'

if (
    $text.Contains($errorConvergence1) -or
    $text.Contains($errorConvergence2)
) {
    Write-Host "[PASS] Error convergence mathematics found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Error convergence mathematics missing." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 16. EOF STRUCTURE
# ------------------------------------------------------------

Write-Host ""
Write-Host "15. EOF structure" -ForegroundColor Yellow

if (
    $lines.Count -ge 2 -and
    $lines[$lines.Count - 1] -ceq "**End of SRM-0017**" -and
    $lines[$lines.Count - 2] -ceq ""
) {
    Write-Host "[PASS] EOF structure is correct." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] EOF structure is incorrect." -ForegroundColor Red

    if ($lines.Count -ge 1) {
        Write-Host "Last line        : [$($lines[$lines.Count - 1])]"
    }

    if ($lines.Count -ge 2) {
        Write-Host "Second-last line : [$($lines[$lines.Count - 2])]"
    }

    $pass = $false
}

# ------------------------------------------------------------
# 17. BYTE-LEVEL UTF-8 CHECK
# ------------------------------------------------------------

Write-Host ""
Write-Host "16. UTF-8 byte encoding" -ForegroundColor Yellow

$bytes = [System.IO.File]::ReadAllBytes(
    (Resolve-Path -LiteralPath $path).Path
)

$utf8Bom = (
    $bytes.Count -ge 3 -and
    $bytes[0] -eq 0xEF -and
    $bytes[1] -eq 0xBB -and
    $bytes[2] -eq 0xBF
)

if ($utf8Bom) {
    Write-Host "[INFO] UTF-8 BOM detected." -ForegroundColor DarkYellow
}
else {
    Write-Host "[PASS] No UTF-8 BOM detected." -ForegroundColor Green
}

# Verify the em dash exists as UTF-8 bytes E2 80 94.
$emDashBytesFound = $false

for ($i = 0; $i -le $bytes.Count - 3; $i++) {
    if (
        $bytes[$i] -eq 0xE2 -and
        $bytes[$i + 1] -eq 0x80 -and
        $bytes[$i + 2] -eq 0x94
    ) {
        $emDashBytesFound = $true
        break
    }
}

if ($emDashBytesFound) {
    Write-Host "[PASS] U+2014 UTF-8 byte sequence E2 80 94 found." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] U+2014 UTF-8 byte sequence not found." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 18. GIT STATUS
# ------------------------------------------------------------

Write-Host ""
Write-Host "17. Git working-tree status" -ForegroundColor Yellow

git status --short -- $path

if ($LASTEXITCODE -eq 0) {
    Write-Host "[PASS] Git status query completed." -ForegroundColor Green
}
else {
    Write-Host "[FAIL] Git status query failed." -ForegroundColor Red
    $pass = $false
}

# ------------------------------------------------------------
# 19. CONTENT HASH
# ------------------------------------------------------------

Write-Host ""
Write-Host "18. SHA-256 content fingerprint" -ForegroundColor Yellow

$hash = Get-FileHash `
    -LiteralPath $path `
    -Algorithm SHA256

Write-Host "SHA256 : $($hash.Hash)" -ForegroundColor Gray

# ------------------------------------------------------------
# FINAL RESULT
# ------------------------------------------------------------

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

if ($pass) {
    Write-Host " SRM-0017 FINAL DETERMINISTIC AUDIT PASSED" -ForegroundColor Green
    Write-Host " ARTIFACT READY FOR COMMIT GATE" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    exit 0
}
else {
    Write-Host " SRM-0017 FINAL DETERMINISTIC AUDIT FAILED" -ForegroundColor Red
    Write-Host " ARTIFACT MUST NOT BE COMMITTED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Cyan
    exit 1
}
