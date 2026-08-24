$ErrorActionPreference = "Stop"

$Repo = "C:\Users\BONOLO RAMOLLO\Documents\SMOF\smof-kernel"
$BranchExpected = "release/foundation-v1.0"

$PlatformDir = Join-Path $Repo "docs\canon\platform"
$Path = Join-Path $PlatformDir "PM-0007-Data-Mathematics.md"

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " SMOF PM-0007 DATA MATHEMATICS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------
# Repository and branch contract
# ------------------------------------------------

if (-not (Test-Path (Join-Path $Repo ".git"))) {
    throw "Not a Git repository: $Repo"
}

Set-Location $Repo

$Branch = (git branch --show-current).Trim()

if ($Branch -ne $BranchExpected) {
    throw "Expected branch $BranchExpected, detected $Branch"
}

Write-Host "[PASS] Repository detected." -ForegroundColor Green
Write-Host "[PASS] Branch: $Branch" -ForegroundColor Green

# ------------------------------------------------
# Protected artifacts
# ------------------------------------------------

$Protected = @(
    ".\docs\canon\platform\PM-0001-Platform-Mathematical-Model.md",
    ".\docs\canon\platform\PM-0002-Multi-Tenant-Mathematics.md",
    ".\docs\canon\platform\PM-0003-Compliance-Mathematics.md",
    ".\docs\canon\platform\PM-0004-Billing-Mathematics.md",
    ".\docs\canon\platform\PM-0005-Observability-Mathematics.md",
    ".\docs\canon\platform\PM-0006-Security-Mathematics.md"
)

foreach ($File in $Protected) {
    if (-not (Test-Path $File)) {
        throw "Protected artifact missing: $File"
    }
}

$Before = @{}

foreach ($File in $Protected) {
    $Before[$File] = (Get-FileHash $File -Algorithm SHA256).Hash
}

New-Item -ItemType Directory -Force -Path $PlatformDir | Out-Null

# ------------------------------------------------
# Canonical artifact
# ------------------------------------------------

$Content = @'
# PM-0007 - Data Mathematics

**Document ID:** PM-0007
**Document Type:** Platform Mathematical Canon
**Title:** Data Mathematics
**Status:** Canonical
**Version:** 1.0
**Parent Model:** PM-0001 - Platform Mathematical Model
**Dependencies:** PM-0001 - Platform Mathematical Model; PM-0002 - Multi-Tenant Mathematics; PM-0003 - Compliance Mathematics; PM-0004 - Billing Mathematics; PM-0005 - Observability Mathematics; PM-0006 - Security Mathematics; SRM-0002 - Runtime Transition
**Domain:** SMOF Platform Mathematics

---

## 1. Purpose

This document defines the canonical mathematical model for data within the SMOF platform mathematics domain.

Data is modeled as a mathematical object possessing identity, type, value, state, provenance, lineage, and contextual classification.

The purpose of this canon is to establish a formal mathematical boundary within which data objects may be represented, typed, transformed, composed, transitioned, verified, and coupled to other SMOF mathematical domains.

This document defines data mathematics.

It does not prescribe a particular database, storage engine, file format, serialization protocol, message broker, programming language, schema language, or implementation architecture.

---

## 2. Dependencies

PM-0007 depends upon the following canonical artifacts:

- PM-0001 - Platform Mathematical Model
- PM-0002 - Multi-Tenant Mathematics
- PM-0003 - Compliance Mathematics
- PM-0004 - Billing Mathematics
- PM-0005 - Observability Mathematics
- PM-0006 - Security Mathematics
- SRM-0002 - Runtime Transition

PM-0007 consumes the mathematical structures established by these artifacts and does not redefine their foundational domains.

---

## 3. Data Universe

Let

\[
\mathcal{D}
\]

denote the universe of canonical SMOF data objects.

The data universe is partitioned conceptually as:

\[
\mathcal{D}
=
\mathcal{D}_{atomic}
\cup
\mathcal{D}_{structured}
\cup
\mathcal{D}_{stream}
\cup
\mathcal{D}_{derived}
\]

where:

- \(\mathcal{D}_{atomic}\) denotes atomic data objects;
- \(\mathcal{D}_{structured}\) denotes structured data objects;
- \(\mathcal{D}_{stream}\) denotes ordered data sequences;
- \(\mathcal{D}_{derived}\) denotes data produced through admissible transformation.

The partition is mathematical rather than implementation-specific.

A concrete database record, file, message, telemetry item, document, event, or stream may instantiate a member of \(\mathcal{D}\).

---

## 4. Data Object Model

A canonical data object is represented as:

\[
d=
(id,\tau,v,\sigma,\pi,\lambda,\kappa)
\]

where:

- \(id\) is the mathematical identity;
- \(\tau\) is the data type or schema;
- \(v\) is the value or content;
- \(\sigma\) is the data state;
- \(\pi\) is provenance;
- \(\lambda\) is lineage;
- \(\kappa\) is classification and contextual information.

Therefore:

\[
d\in\mathcal{D}
\]

The data object and its value are distinct mathematical entities.

In particular:

\[
d_1=d_2
\]

is stronger than:

\[
v(d_1)=v(d_2)
\]

because identity, state, provenance, lineage, and context may differ.

---

## 5. Identity and Type Mathematics

Define the data identity function:

\[
I_D:\mathcal{D}\rightarrow\mathcal{I}_D
\]

where \(\mathcal{I}_D\) is the universe of data identities.

Two data objects are data-identity equivalent iff:

\[
d_1\equiv_D d_2
\iff
I_D(d_1)=I_D(d_2)
\]

Define the data type universe:

\[
\mathcal{T}_D
\]

and the typing function:

\[
T_D:\mathcal{D}\rightarrow\mathcal{T}_D
\]

For a data object \(d\), let:

\[
T_D(d)=\tau
\]

A typed data object is valid only when its value conforms to its declared type:

\[
ValidType(d)=1
\iff
v(d)\models T_D(d)
\]

Identity and type are therefore independent dimensions.

---

## 6. Data State Model

Let:

\[
\mathcal{S}_D
\]

denote the canonical data-state universe.

The state function is:

\[
\sigma_D:\mathcal{D}\rightarrow\mathcal{S}_D
\]

Canonical state classes may include:

\[
Created,\ Valid,\ Invalid,\ Active,\ Archived,\ Superseded,\ Deleted
\]

These names represent mathematical state classes and do not mandate implementation-level enumerations.

At a given runtime point, a canonical data object occupies exactly one admissible data state.

The data value:

\[
v(d)
\]

and data state:

\[
\sigma_D(d)
\]

must not be identified as the same mathematical object.

---

## 7. Provenance Mathematics

Let:

\[
\mathcal{P}_D
\]

denote the provenance universe.

Define:

\[
P_D:\mathcal{D}\rightarrow\mathcal{P}_D
\]

Provenance identifies mathematically relevant origin and contextual information associated with data.

Depending on the applicable domain, provenance may represent:

- origin;
- source;
- actor;
- runtime context;
- temporal context;
- transformation context;
- parent data.

Provenance is not equivalent to observability logging.

PM-0005 may observe provenance-related events, while PM-0007 defines provenance as a property of data.

---

## 8. Lineage Mathematics

Let:

\[
\mathcal{L}_D
\subseteq
\mathcal{D}\times\mathcal{D}
\]

denote the canonical data-lineage relation.

For:

\[
d'=O_D(d)
\]

where \(O_D\) is an admissible data transformation, the relation:

\[
(d,d')\in\mathcal{L}_D
\]

records the mathematical derivation relationship where lineage is applicable.

Define:

\[
Lineage(d')
=
\{d\in\mathcal{D}\mid(d,d')\in\mathcal{L}_D\}
\]

Lineage therefore describes dependency and derivation.

Lineage is not itself an audit log.

---

## 9. Transformation Mathematics

Let:

\[
\mathcal{O}_D
\]

denote the universe of admissible data operators.

A generalized data transformation is:

\[
O_D:
\mathcal{D}^{n}
\rightarrow
\mathcal{D}^{m}
\]

for admissible integers \(n,m\geq1\).

This permits:

- one-to-one transformations;
- one-to-many transformations;
- many-to-one transformations;
- many-to-many transformations.

For:

\[
O_D(d_1,\ldots,d_n)
=
(d'_1,\ldots,d'_m)
\]

the operation is admissible only if its domain, codomain, typing, state, tenant, security, provenance, lineage, and other applicable constraints are satisfied.

---

## 10. Data Composition Mathematics

Define the canonical data-composition operator:

\[
\oplus_D
\]

For:

\[
d_3=d_1\oplus_Dd_2
\]

composition is admissible only when:

\[
Compat_D(d_1,d_2)=1
\]

The compatibility relation may include:

\[
Type
\]

\[
Tenant
\]

\[
Security
\]

\[
Schema
\]

\[
Provenance
\]

and any other applicable canonical constraint.

Composition does not imply arbitrary commutativity, associativity, or invertibility.

Such properties must be established for a particular operator rather than assumed globally.

---

## 11. Data Classification and Context

Let:

\[
\mathcal{K}_D
\]

denote the universe of data classifications and contextual attributes.

Define:

\[
K_D:\mathcal{D}\rightarrow\mathcal{K}_D
\]

Classification may include mathematically relevant properties such as:

- sensitivity;
- operational role;
- provenance class;
- retention class;
- semantic class;
- security-relevant classification.

PM-0007 defines the mathematical existence of classification.

Specific compliance and security meanings remain governed by PM-0003 and PM-0006.

---

## 12. Data Transition Model

Define the data transition function:

\[
\delta_D:
\mathcal{S}_D\times\mathcal{O}_D
\rightarrow
\mathcal{S}_D
\]

For a state \(s_t\) and admissible data operator \(o\):

\[
s_{t+1}
=
\delta_D(s_t,o)
\]

A data transition is admissible iff:

\[
Admissible_D(s_t,o,s_{t+1})=1
\]

and the resulting state satisfies all canonical data invariants.

The data transition model is a domain specialization of the broader SRM runtime transition model.

---

## 13. Tenant Data Isolation

Let:

\[
\mathcal{T}
\]

denote the tenant universe established by PM-0002.

Define the tenant-context function:

\[
\Theta_D:\mathcal{D}\rightarrow\mathcal{T}
\]

for tenant-scoped data.

For an operation:

\[
O_D(d_1,\ldots,d_n)=d'
\]

the resulting tenant relation must satisfy the applicable tenant admissibility relation:

\[
R_T
\left(
\Theta_D(d_1),
\ldots,
\Theta_D(d_n),
\Theta_D(d')
\right)
=1
\]

Cross-tenant data composition is therefore not assumed to be valid.

An explicit admissible relation is required.

PM-0007 consumes the tenant mathematics of PM-0002 and does not redefine it.

---

## 14. Data-Security and Compliance Coupling

Data operations may be subject to security and compliance constraints.

Define the security compatibility predicate:

\[
Sec_D(d,o)=1
\]

when operation \(o\) is compatible with the applicable security state and authorization requirements of PM-0006.

Define the compliance compatibility predicate:

\[
Comp_D(d,o)=1
\]

when operation \(o\) is compatible with applicable compliance mathematics established by PM-0003.

Therefore a constrained data operation requires:

\[
Sec_D(d,o)=1
\]

and:

\[
Comp_D(d,o)=1
\]

where applicable.

PM-0007 does not redefine security authorization or compliance rules.

---

## 15. Data Invariants

The following ten invariants are canonical.

### Invariant 1 - Data Identity

Every canonical data object possesses a stable mathematical identity:

\[
I_D(d)\in\mathcal{I}_D
\]

### Invariant 2 - Type Consistency

Every valid data object conforms to its declared mathematical type:

\[
ValidType(d)=1
\]

### Invariant 3 - State Consistency

Every canonical data object occupies exactly one admissible state at a given runtime point.

### Invariant 4 - Tenant Context Preservation

Tenant-scoped data retains its applicable tenant context across admissible operations.

### Invariant 5 - Provenance Preservation

Required provenance is preserved across admissible transformations.

### Invariant 6 - Lineage Preservation

Derived data retains the required mathematical lineage relationship to its source data.

### Invariant 7 - Transformation Validity

A data transformation is admissible only when its inputs, outputs, domain, codomain, and applicable constraints are valid.

### Invariant 8 - Security Compatibility

Data operations remain compatible with all applicable canonical security constraints.

### Invariant 9 - Composition Validity

Data composition is admissible only when the required compatibility relations hold.

### Invariant 10 - State Transition Consistency

Every admissible data transition produces a resulting state satisfying Invariants 1 through 9.

---

## 16. Verification Conditions

The following twelve verification conditions define canonical data verification requirements.

### VC-01 Data Identity

Verify that every canonical data object possesses a valid data identity.

### VC-02 Type Conformance

Verify that each valid data object conforms to its declared type.

### VC-03 State Validity

Verify that each data object occupies an admissible canonical state.

### VC-04 Tenant Context

Verify that tenant-scoped data retains valid tenant context.

### VC-05 Provenance Preservation

Verify that required provenance survives applicable transformations.

### VC-06 Lineage Preservation

Verify that derived data preserves required lineage.

### VC-07 Transformation Domain

Verify that every data transformation receives inputs from its declared mathematical domain.

### VC-08 Transformation Codomain

Verify that every transformation produces outputs belonging to its declared codomain.

### VC-09 Security Compatibility

Verify that data operations satisfy applicable PM-0006 security constraints.

### VC-10 Composition Validity

Verify that every data composition satisfies the required compatibility relations.

### VC-11 Transition Admissibility

Verify that every data-state transition satisfies the canonical transition relation.

### VC-12 Invariant Preservation

Verify that every resulting canonical data state satisfies all ten data invariants.

---

## 17. Relationship to PM-0001

PM-0001 establishes the foundational platform mathematical model.

PM-0007 specializes that foundation to the data domain.

Therefore:

\[
PM\text{-}0007
\rightarrow
PM\text{-}0001
\]

for foundational mathematical semantics.

PM-0007 does not replace or redefine PM-0001.

---

## 18. Relationship to PM-0002

PM-0002 establishes multi-tenant mathematics.

PM-0007 applies that tenant model to data through:

\[
\Theta_D
\]

and tenant admissibility relations.

Thus:

\[
PM\text{-}0002
\rightarrow
TenantConstraint
\rightarrow
PM\text{-}0007
\]

PM-0007 does not redefine tenant mathematics.

---

## 19. Relationship to PM-0003

PM-0003 establishes compliance mathematics.

PM-0007 represents compliance-relevant data and operations subject to the applicable compliance constraints.

Therefore:

\[
Comp_D(d,o)=1
\]

is required where applicable.

PM-0007 does not redefine compliance mathematics.

---

## 20. Relationship to PM-0004

PM-0004 establishes billing mathematics.

Billing records, quantities, measurements, transactions, and usage representations may be instantiated as members of:

\[
\mathcal{D}
\]

PM-0007 therefore supplies data semantics to billing without redefining billing mathematics.

---

## 21. Relationship to PM-0005

PM-0005 establishes observability mathematics.

Observability signals, events, and logs may be represented as data objects.

Conceptually:

\[
Signal\subseteq\mathcal{D}
\]

\[
Event\subseteq\mathcal{D}
\]

\[
Log\subseteq\mathcal{D}
\]

where applicable.

PM-0005 remains authoritative for observability semantics.

PM-0007 remains authoritative for data semantics.

---

## 22. Relationship to PM-0006

PM-0006 establishes security mathematics.

Data operations are constrained by applicable identity, authorization, trust, credential, cryptographic, and security-state requirements.

Therefore:

\[
Sec_D(d,o)=1
\]

must hold where security constraints apply.

PM-0007 does not redefine security mathematics.

---

## 23. Relationship to SRM

SRM defines the broader runtime transition model:

\[
S\xrightarrow{O}S'
\]

PM-0007 specializes this relationship to data:

\[
S_D\xrightarrow{O_D}S_D'
\]

Therefore:

\[
\delta_D
\]

is a data-domain specialization of runtime transition mathematics.

Every admissible data transition must remain compatible with the applicable SRM transition semantics.

---

## 24. Future Resource Coupling

Future Resource Mathematics defines:

\[
\mathcal{R}
\]

without redefining:

\[
\mathcal{D}
\]

The domains may be coupled through relations such as:

\[
Produces_R(r,d)
\]

\[
Consumes_R(r,d)
\]

\[
Stores_R(r,d)
\]

\[
Allocates_R(r,d)
\]

These relations establish interaction without collapsing the resource and data domains.

---

## 25. Future Policy Coupling

Future Policy Mathematics defines:

\[
\mathcal{P}
\]

and policy evaluation over applicable mathematical contexts.

A policy may evaluate a tuple containing:

\[
(d,r,s,o)
\]

and produce:

\[
P(d,r,s,o)\in\{0,1\}
\]

Policy mathematics therefore constrains data mathematics without becoming part of the data universe.

---

## 26. Future Workflow Coupling

Future Workflow Mathematics defines workflow state sequences and dependency graphs.

A workflow may contain data transformations:

\[
d_0
\xrightarrow{O_1}
d_1
\xrightarrow{O_2}
d_2
\]

while the broader runtime transition remains:

\[
S_0
\xrightarrow{O_1}
S_1
\xrightarrow{O_2}
S_2
\]

Workflow mathematics therefore composes admissible data and runtime operators without redefining their domains.

---

## 27. Domain Coupling Mathematics

SMOF domain coupling is defined through explicit mathematical mechanisms:

\[
\boxed{
Coupling
=
Relations
+
Predicates
+
Operators
+
Transitions
}
\]

The principal domains remain mathematically distinct:

\[
\mathcal{D},
\mathcal{R},
\mathcal{P},
\mathcal{W}
\]

while interacting through explicit admissible relations.

No domain acquires authority over another domain merely by reference.

---

## 28. Canonical Boundary

PM-0007 defines:

- data identity;
- data types;
- data values;
- data states;
- provenance;
- lineage;
- classification;
- data transformations;
- data composition;
- data transitions;
- tenant data context;
- security compatibility;
- compliance compatibility;
- data invariants;
- data verification conditions.

PM-0007 does not define:

- a concrete database;
- a concrete storage engine;
- a concrete file format;
- a concrete serialization protocol;
- a concrete messaging system;
- a concrete encryption algorithm;
- a concrete authorization product;
- a concrete compliance regime;
- a concrete resource allocator;
- a concrete policy engine;
- a concrete workflow engine;
- a programming-language implementation.

The canonical mathematical boundary is therefore:

\[
\boxed{
PM\text{-}0007
=
\text{Data Mathematics}
}
\]

and not a concrete data-management architecture.

---

## 29. Canonical Coupling Principle

The canonical SMOF principle established by PM-0007 is:

\[
\boxed{
\text{Distinct mathematical domains}
\quad+\quad
\text{explicit coupling relations}
}
\]

rather than implicit inheritance or implementation-level dependency.

Data is therefore a foundational mathematical domain upon which future Resource, Policy, and Workflow mathematics may operate.

---
'@
# Normalize and write canonical artifact

New-Item -ItemType Directory -Force -Path $PlatformDir | Out-Null

$Content = $Content.TrimEnd("`r","`n") + "`n"

[System.IO.File]::WriteAllText(
    $Path,
    $Content,
    $Utf8NoBom
)

# ------------------------------------------------
# Encoding audit
# ------------------------------------------------

$Bytes = [System.IO.File]::ReadAllBytes((Resolve-Path $Path))
$CheckText = [System.IO.File]::ReadAllText((Resolve-Path $Path), $Utf8NoBom)

$HasBom = $false

if ($Bytes.Length -ge 3) {
    $HasBom = (
        $Bytes[0] -eq 0xEF -and
        $Bytes[1] -eq 0xBB -and
        $Bytes[2] -eq 0xBF
    )
}

$HasCR = $CheckText.Contains("`r")
$HasFinalLF = $CheckText.EndsWith("`n")
$HasDoubleFinalLF = $CheckText.EndsWith("`n`n")

if ($HasBom) {
    throw "PM-0007 has UTF-8 BOM."
}

if ($HasCR) {
    throw "PM-0007 contains CR characters."
}

if (-not $HasFinalLF) {
    throw "PM-0007 does not end with LF."
}

if ($HasDoubleFinalLF) {
    throw "PM-0007 contains multiple final LF characters."
}

Write-Host "[PASS] PM-0007 generated." -ForegroundColor Green
Write-Host "[PASS] UTF-8 BOM absent." -ForegroundColor Green
Write-Host "[PASS] LF-only endings." -ForegroundColor Green
Write-Host "[PASS] Exactly one final LF." -ForegroundColor Green

# ------------------------------------------------
# Canonical section audit
# ------------------------------------------------

$Sections = @(
    "## 1. Purpose",
    "## 2. Dependencies",
    "## 3. Data Universe",
    "## 4. Data Object Model",
    "## 5. Identity and Type Mathematics",
    "## 6. Data State Model",
    "## 7. Provenance Mathematics",
    "## 8. Lineage Mathematics",
    "## 9. Transformation Mathematics",
    "## 10. Data Composition Mathematics",
    "## 11. Data Classification and Context",
    "## 12. Data Transition Model",
    "## 13. Tenant Data Isolation",
    "## 14. Data-Security and Compliance Coupling",
    "## 15. Data Invariants",
    "## 16. Verification Conditions",
    "## 17. Relationship to PM-0001",
    "## 18. Relationship to PM-0002",
    "## 19. Relationship to PM-0003",
    "## 20. Relationship to PM-0004",
    "## 21. Relationship to PM-0005",
    "## 22. Relationship to PM-0006",
    "## 23. Relationship to SRM",
    "## 24. Future Resource Coupling",
    "## 25. Future Policy Coupling",
    "## 26. Future Workflow Coupling",
    "## 27. Domain Coupling Mathematics",
    "## 28. Canonical Boundary",
    "## 29. Canonical Coupling Principle"
)

Write-Host ""
Write-Host "--- CANONICAL SECTION AUDIT ---" -ForegroundColor Cyan

foreach ($Section in $Sections) {
    if (-not $CheckText.Contains($Section)) {
        throw "Missing canonical section: $Section"
    }

    Write-Host "[PASS] $Section" -ForegroundColor Green
}

# ------------------------------------------------
# Mathematical invariant audit
# ------------------------------------------------

$InvariantMatches = [regex]::Matches(
    $CheckText,
    "(?m)^### Invariant [1-9][0-9]*\b"
)

if ($InvariantMatches.Count -ne 10) {
    throw "Expected exactly 10 data invariants; found $($InvariantMatches.Count)."
}

Write-Host "[PASS] Exactly ten data invariants." -ForegroundColor Green

# ------------------------------------------------
# Verification condition audit
# ------------------------------------------------

$VerificationMatches = [regex]::Matches(
    $CheckText,
    "(?m)^### VC-[0-9]{2}\b"
)

if ($VerificationMatches.Count -ne 12) {
    throw "Expected exactly 12 verification conditions; found $($VerificationMatches.Count)."
}

Write-Host "[PASS] Exactly twelve verification conditions." -ForegroundColor Green

# ------------------------------------------------
# Mathematical symbol audit
# ------------------------------------------------

$RequiredSymbols = @(
    "\mathcal{D}",
    "\mathcal{O}_D",
    "\mathcal{S}_D",
    "I_D",
    "T_D",
    "P_D",
    "\mathcal{L}_D",
    "\delta_D",
    "\Theta_D",
    "\oplus_D"
)

foreach ($Symbol in $RequiredSymbols) {
    if (-not $CheckText.Contains($Symbol)) {
        throw "Required mathematical symbol missing: $Symbol"
    }
}

Write-Host "[PASS] Required canonical mathematical structures present." -ForegroundColor Green

# ------------------------------------------------
# Dependency audit
# ------------------------------------------------

$RequiredDependencies = @(
    "PM-0001",
    "PM-0002",
    "PM-0003",
    "PM-0004",
    "PM-0005",
    "PM-0006",
    "SRM-0002"
)

foreach ($Dependency in $RequiredDependencies) {
    if (-not $CheckText.Contains($Dependency)) {
        throw "Required dependency missing from PM-0007: $Dependency"
    }
}

Write-Host "[PASS] PM-0001 through PM-0006 and SRM-0002 referenced." -ForegroundColor Green

# ------------------------------------------------
# Protected artifact integrity
# ------------------------------------------------

foreach ($File in $Protected) {
    $After = (Get-FileHash $File -Algorithm SHA256).Hash

    if ($After -ne $Before[$File]) {
        throw "Protected artifact modified: $File"
    }
}

Write-Host "[PASS] PM-0001 through PM-0006 were not modified by this generator." -ForegroundColor Green

# ------------------------------------------------
# Git diff check
# ------------------------------------------------

git diff --check

if ($LASTEXITCODE -ne 0) {
    throw "git diff --check failed."
}

Write-Host "[PASS] git diff --check." -ForegroundColor Green

# ------------------------------------------------
# Final artifact report
# ------------------------------------------------

Write-Host ""
Write-Host "--- PM-0007 FILE ---" -ForegroundColor Yellow

Get-Item $Path |
    Select-Object Name, Length

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " PM-0007 DATA MATHEMATICS COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
