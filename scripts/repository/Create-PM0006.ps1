$ErrorActionPreference = "Stop"

$Repo = "C:\Users\BONOLO RAMOLLO\Documents\SMOF\smof-kernel"
$BranchExpected = "release/foundation-v1.0"

$PlatformDir = Join-Path $Repo "docs\canon\platform"
$Path = Join-Path $PlatformDir "PM-0006-Security-Mathematics.md"

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " SMOF PM-0006 SECURITY MATHEMATICS" -ForegroundColor Cyan
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
    ".\docs\canon\platform\PM-0005-Observability-Mathematics.md"
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
# PM-0006 - Security Mathematics

**Document ID:** PM-0006
**Document Type:** Platform Mathematical Canon
**Title:** Security Mathematics
**Status:** Canonical
**Version:** 1.0
**Parent Model:** PM-0001 - Platform Mathematical Model
**Dependencies:** PM-0001 - Platform Mathematical Model; PM-0002 - Multi-Tenant Mathematics; PM-0003 - Compliance Mathematics; PM-0004 - Billing Mathematics; PM-0005 - Observability Mathematics; SRM-0002 - Runtime Transition
**Domain:** SMOF Platform Mathematics

---

## 1. Purpose

This document defines the canonical mathematical model for security within the SMOF platform mathematics domain.

Security is modeled as a state-dependent system of identities, authentication predicates, authorization predicates, trust relations, cryptographic objects, credentials, security events, and admissible transitions.

The purpose of this canon is to establish a mathematical boundary within which security-relevant platform states and transformations may be represented, evaluated, composed, verified, and related to the broader SMOF runtime.

This document defines security mathematics. It does not prescribe a particular cryptographic library, authentication protocol, authorization engine, network topology, operating system mechanism, or implementation architecture.

---

## 2. Dependencies

PM-0006 depends upon the following canonical artifacts:

- PM-0001 - Platform Mathematical Model
- PM-0002 - Multi-Tenant Mathematics
- PM-0003 - Compliance Mathematics
- PM-0004 - Billing Mathematics
- PM-0005 - Observability Mathematics
- SRM-0002 - Runtime Transition

PM-0001 establishes the platform mathematical universe.

PM-0002 establishes tenant identity, tenant domains, and multi-tenant separation.

PM-0003 establishes compliance constraints and admissibility conditions.

PM-0004 establishes billing states and financially relevant transitions.

PM-0005 establishes observable signals, events, traces, logs, and monitoring states.

SRM-0002 establishes runtime transition semantics.

PM-0006 introduces security mathematics as a constrained state model compatible with these artifacts.

---

## 3. Security Universe

Let:

    T

denote the set of tenants,

    B

denote the set of platform boundaries or bounded execution domains,

    X

denote the set of principals,

    R

denote the set of roles,

    O

denote the set of protected objects,

    K

denote the set of cryptographic key states,

    C

denote the set of credential states,

    E_s

denote the set of security events,

and:

    Sigma_s

denote the security state space.

A security state is written:

    S_s(t,b) in Sigma_s

where:

    t in T
    b in B

The security universe is therefore:

    U_s = T x B x Sigma_s

Security is evaluated relative to both tenant identity and platform boundary.

No security predicate defined by this canon is assumed to be globally valid independently of its admissible tenant and boundary context.

---

## 4. Security State Model

For tenant t and boundary b, define the security state:

    S_s(t,b) =
        (
            Id(t,b),
            A(t,b),
            Z(t,b),
            Trust(t,b),
            K(t,b),
            C(t,b),
            E_s(t,b)
        )

where:

    Id(t,b)

is the identity state,

    A(t,b)

is the authentication state,

    Z(t,b)

is the authorization state,

    Trust(t,b)

is the trust state,

    K(t,b)

is the cryptographic key state,

    C(t,b)

is the credential state,

and:

    E_s(t,b)

is the security event state.

A valid security state must satisfy the security invariants defined in Section 15.

---

## 5. Identity Model

Let:

    x in X

denote a principal.

The identity predicate is:

    Identified(x,t,b)

A principal is security-addressable within a tenant and boundary only if:

    Identified(x,t,b) = true

Define the tenant-bound identity relation:

    IdRel(x,t,b)

Identity uniqueness requires that an active security identity resolve to at most one canonical principal within its admissible identity namespace.

Formally, for identities x_1 and x_2:

    IdRel(x_1,t,b) = IdRel(x_2,t,b)
    implies
    x_1 = x_2

within the same canonical identity domain.

Identity equivalence across distinct tenants is not assumed.

---

## 6. Authentication Mathematics

Authentication determines whether a presented principal satisfies an admissible identity proof.

Define:

    Auth(x,t,b) in {0,1}

where:

    Auth(x,t,b) = 1

means principal x is authenticated for tenant t and boundary b.

Authentication requires identity resolution and credential validity:

    Auth(x,t,b) = 1
    implies
    Identified(x,t,b) = true

and:

    ValidCred(x,t,b) = true

Therefore:

    Auth(x,t,b) = 1
    implies
    Identified(x,t,b) and ValidCred(x,t,b)

Authentication success does not itself imply authorization.

---

## 7. Authorization Mathematics

Let:

    r in R

denote a requested action or protected operation, and let:

    o in O

denote a protected object.

Define the authorization predicate:

    Permit(x,r,o,t,b) in {0,1}

Authorization is admissible only when the principal is authenticated and the requested operation belongs to the permitted security relation.

Thus:

    Permit(x,r,o,t,b) = 1
    implies
    Auth(x,t,b) = 1

Define the authorization relation:

    ZRel(x,r,o,t,b)

such that:

    Permit(x,r,o,t,b) = 1
    iff
    ZRel(x,r,o,t,b) is admissible

Authorization is therefore a context-dependent predicate rather than a global property of a principal.

---

## 8. Trust Model

Define the trust relation:

    Trust(x,y,t,b)

where x and y are security principals, services, processes, or bounded security entities.

Trust is not assumed to be symmetric.

Therefore:

    Trust(x,y,t,b)

does not imply:

    Trust(y,x,t,b)

Trust is also not assumed to be transitive.

Therefore:

    Trust(x,y,t,b)
    and
    Trust(y,z,t,b)

do not necessarily imply:

    Trust(x,z,t,b)

A trust relation is admissible only within a defined tenant and boundary context.

---

## 9. Cryptographic Security Model

Let:

    K(t,b)

denote the set of active cryptographic key states for tenant t and boundary b.

For key k in K(t,b), define:

    KeyValid(k,t,b)

as the predicate that key k is valid for its intended security operation.

A cryptographic operation is admissible only if its required key state is valid:

    CryptoOp(k,t,b) = 1
    implies
    KeyValid(k,t,b) = true

Key material is modeled as a security state object.

This canon does not define a specific encryption algorithm, signature algorithm, key length, or implementation primitive.

The mathematical requirement is preservation of cryptographic state validity across admissible transitions.

---

## 10. Key and Credential Lifecycle

A key or credential state evolves through an admissible lifecycle.

Let:

    L_c

denote the lifecycle state space.

For credential c:

    State(c) in L_c

An abstract credential lifecycle may contain states:

    issued
    active
    suspended
    expired
    revoked

An abstract key lifecycle may contain states:

    generated
    active
    rotated
    retired
    revoked

Define:

    LifeTrans(q_1,q_2)

as the admissibility predicate for a lifecycle transition from q_1 to q_2.

A security lifecycle transition is valid only when:

    LifeTrans(q_1,q_2) = true

Invalid transitions must not produce a canonical valid security state.

---

## 11. Security Event Model

Let:

    e in E_s

denote a security event.

Define the event projection:

    Event(e,t,b)

A security event may represent a mathematically observable security-relevant occurrence, including authentication outcomes, authorization outcomes, credential transitions, key transitions, trust-boundary interactions, or security-state transitions.

The event state is tenant-bound:

    Event(e,t_1,b) and Event(e,t_2,b)

do not imply that the event is shared across tenants when:

    t_1 != t_2

Security events may be related to the observability mathematics defined in PM-0005 without becoming identical to general observability signals.

---

## 12. Security Transition Model

Let:

    Theta_s

denote the set of security transition operators.

For:

    theta in Theta_s

define:

    theta : Sigma_s -> Sigma_s

A security transition is written:

    S_s' = theta(S_s)

For tenant and boundary context:

    S_s'(t,b) = theta(S_s(t,b))

A transition is admissible only if:

1. its preconditions hold,
2. its identity constraints hold,
3. its authorization constraints hold,
4. its tenant boundary is preserved,
5. its lifecycle constraints hold,
6. and its resulting state satisfies all canonical security invariants.

---

## 13. Tenant Security Isolation

For distinct tenants:

    t_1 != t_2

define security isolation as:

    Iso_s(t_1,t_2) = true

Tenant security isolation requires that security authority belonging to one tenant does not automatically establish authority within another tenant.

Therefore:

    Permit(x,r,o,t_1,b) = 1

does not imply:

    Permit(x,r,o,t_2,b) = 1

when:

    t_1 != t_2

Likewise, identity, trust, credential, and cryptographic state must be interpreted within their admissible tenant domain.

Cross-tenant security interaction requires an explicitly admissible relation.

---

## 14. Security Composition

Let:

    theta_1, theta_2 in Theta_s

be security transition operators.

Their composition is:

    theta_2 o theta_1

where:

    (theta_2 o theta_1)(S_s)
    =
    theta_2(theta_1(S_s))

A composed security transition is canonical only if each constituent transition is admissible and the composed result preserves all security invariants.

Formally:

    Valid(theta_1,S_s)
    and
    Valid(theta_2,theta_1(S_s))
    implies
    Valid(theta_2 o theta_1,S_s)

Composition does not permit an invalid intermediate state to be treated as canonical merely because a later transition restores validity.

---

## 15. Security Invariants

The following ten invariants are canonical.

### Invariant 1 - Identity Uniqueness

Within an admissible tenant and identity domain, one canonical active identity resolves to at most one principal.

### Invariant 2 - Authentication Validity

Authenticated state implies resolved identity and valid credential state.

### Invariant 3 - Authorization Soundness

A permitted operation must be associated with an admissible authorization relation.

### Invariant 4 - Authentication Precedence

Authorization success implies authentication success.

### Invariant 5 - Tenant Security Isolation

Security authority in one tenant does not automatically imply authority in another tenant.

### Invariant 6 - Trust Boundary Preservation

Trust relations remain valid only within explicitly admissible trust boundaries.

### Invariant 7 - Credential Lifecycle Validity

A credential may be used only when its lifecycle state permits the requested security operation.

### Invariant 8 - Key State Integrity

A cryptographic operation requires a valid key state for its intended operation.

### Invariant 9 - Security Transition Admissibility

A security state transition must satisfy its canonical preconditions and lifecycle constraints.

### Invariant 10 - Security State Consistency

Every resulting canonical security state satisfies Invariants 1 through 9.

---

## 16. Verification Conditions

The following twelve verification conditions define canonical security verification requirements.

### VC-01 Identity Resolution

Verify that an authenticated principal resolves to an admissible canonical identity.

### VC-02 Identity Uniqueness

Verify that identity resolution does not produce conflicting principals within the same identity domain.

### VC-03 Credential Validity

Verify that authentication requires a valid credential state.

### VC-04 Authentication Validity

Verify that authentication success implies identity resolution and credential validity.

### VC-05 Authorization Soundness

Verify that every permitted operation has an admissible authorization relation.

### VC-06 Authentication Precedence

Verify that authorization success does not occur without required authentication.

### VC-07 Tenant Isolation

Verify that tenant-scoped security authority does not leak across tenant boundaries without an explicit admissible relation.

### VC-08 Trust Boundary

Verify that trust-dependent operations occur only across admissible trust boundaries.

### VC-09 Credential Lifecycle

Verify that credential transitions satisfy the canonical lifecycle relation.

### VC-10 Key State Validity

Verify that cryptographic operations use valid key states.

### VC-11 Transition Admissibility

Verify that a security transition satisfies all required preconditions.

### VC-12 Resulting State Consistency

Verify that the resulting security state satisfies all ten security invariants.

---

## 17. Relationship to PM-0002

PM-0002 defines the mathematical structure of multi-tenant identity and tenant isolation.

PM-0006 refines this structure by defining security relations relative to tenant identity.

For distinct tenants:

    t_1 != t_2

security authority is not transferred by identity coincidence alone.

Tenant isolation therefore forms a required context for authentication, authorization, trust, credential, key, and security-state interpretation.

PM-0006 does not redefine PM-0002. It applies security predicates within the tenant structure established by PM-0002.

---

## 18. Relationship to PM-0003

PM-0003 defines compliance mathematics and admissibility constraints.

PM-0006 provides security predicates and state transitions that may participate in satisfying or enforcing compliance constraints.

Compliance admissibility and security admissibility are distinct predicates.

Therefore:

    Secure(S_s)

does not necessarily imply:

    Compliant(S)

and:

    Compliant(S)

does not necessarily imply:

    Secure(S_s)

A canonical platform state may require both security and compliance conditions to hold simultaneously.

---

## 19. Relationship to PM-0004

PM-0004 defines billing mathematics, invoice state, payment state, settlement, and tenant billing isolation.

PM-0006 provides the security context within which access to billing-relevant operations and protected billing states may be controlled.

Billing correctness does not imply security correctness.

Security correctness does not determine billing amounts.

The relationship is therefore one of controlled admissibility rather than mathematical equivalence.

---

## 20. Relationship to PM-0005

PM-0005 defines observability mathematics for metrics, events, traces, logs, aggregation, sampling, cardinality, and observable state.

PM-0006 defines security events as security-relevant state objects that may be represented within an observability system.

Security observability does not replace security state.

Formally, an observable representation:

    Obs(S_s)

is not identical to:

    S_s

Observability provides a projection of security-relevant information subject to canonical boundary and tenant constraints.

---

## 21. Relationship to SRM

SRM-0002 defines runtime transition mathematics.

PM-0006 specializes runtime transition semantics for security state.

For a runtime transition:

    R' = Tau(R)

a corresponding security projection may evolve as:

    S_s' = theta(S_s)

The security transition must remain compatible with the admissible runtime transition.

Security mathematics does not replace the runtime model. It constrains the security-relevant component of runtime evolution.

---

## 22. Canonical Boundary

PM-0006 defines:

- security state,
- identity mathematics,
- authentication predicates,
- authorization predicates,
- trust relations,
- cryptographic key-state validity,
- credential and key lifecycle constraints,
- security events,
- security transitions,
- tenant security isolation,
- security composition,
- security invariants,
- and verification conditions.

PM-0006 does not define:

- a concrete encryption algorithm,
- a concrete authentication protocol,
- a concrete authorization product,
- a concrete key-management service,
- a concrete network architecture,
- a concrete operating system security model,
- or application-specific security policy implementation.

Such concerns may implement or refine this mathematical canon but must not alter its canonical definitions without an explicit canonical revision.

Security implementation is therefore subordinate to the mathematical constraints defined by PM-0006.

The canonical security state is:

    S_s(t,b) =
        (
            Id(t,b),
            A(t,b),
            Z(t,b),
            Trust(t,b),
            K(t,b),
            C(t,b),
            E_s(t,b)
        )

and a canonical security transition is:

    S_s'(t,b) = theta(S_s(t,b))

subject to all ten security invariants and all applicable verification conditions.
'@

# ------------------------------------------------
# Normalize and write canonical artifact
# ------------------------------------------------

$Content = $Content -replace "`r`n", "`n"
$Content = $Content -replace "`r", "`n"
$Content = $Content.TrimEnd("`n") + "`n"

[System.IO.File]::WriteAllText($Path, $Content, $Utf8NoBom)

# ------------------------------------------------
# Encoding contract
# ------------------------------------------------

$Bytes = [System.IO.File]::ReadAllBytes($Path)
$CheckText = [System.IO.File]::ReadAllText($Path, $Utf8NoBom)

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
    throw "PM-0006 has UTF-8 BOM."
}

if ($HasCR) {
    throw "PM-0006 contains CR characters."
}

if (-not $HasFinalLF) {
    throw "PM-0006 final LF missing."
}

if ($HasDoubleFinalLF) {
    throw "PM-0006 contains multiple final LF characters."
}

Write-Host "[PASS] PM-0006 generated." -ForegroundColor Green
Write-Host "[PASS] UTF-8 BOM absent." -ForegroundColor Green
Write-Host "[PASS] LF-only endings." -ForegroundColor Green
Write-Host "[PASS] Exactly one final LF." -ForegroundColor Green

# ------------------------------------------------
# Canonical section audit
# ------------------------------------------------

$Sections = @(
    "## 1. Purpose",
    "## 2. Dependencies",
    "## 3. Security Universe",
    "## 4. Security State Model",
    "## 5. Identity Model",
    "## 6. Authentication Mathematics",
    "## 7. Authorization Mathematics",
    "## 8. Trust Model",
    "## 9. Cryptographic Security Model",
    "## 10. Key and Credential Lifecycle",
    "## 11. Security Event Model",
    "## 12. Security Transition Model",
    "## 13. Tenant Security Isolation",
    "## 14. Security Composition",
    "## 15. Security Invariants",
    "## 16. Verification Conditions",
    "## 17. Relationship to PM-0002",
    "## 18. Relationship to PM-0003",
    "## 19. Relationship to PM-0004",
    "## 20. Relationship to PM-0005",
    "## 21. Relationship to SRM",
    "## 22. Canonical Boundary"
)

Write-Host ""
Write-Host "--- CANONICAL SECTION AUDIT ---" -ForegroundColor Cyan

foreach ($Section in $Sections) {
    if ($CheckText.Contains($Section)) {
        Write-Host "[PASS] $Section" -ForegroundColor Green
    }
    else {
        throw "Missing canonical section: $Section"
    }
}

# ------------------------------------------------
# Mathematical cardinality audit
# ------------------------------------------------

$InvariantMatches = [regex]::Matches(
    $CheckText,
    "(?m)^### Invariant [1-9][0-9]*\b"
)

if ($InvariantMatches.Count -ne 10) {
    throw "Expected exactly 10 security invariants; found $($InvariantMatches.Count)."
}

$VerificationMatches = [regex]::Matches(
    $CheckText,
    "(?m)^### VC-[0-9]{2}\b"
)

if ($VerificationMatches.Count -ne 12) {
    throw "Expected exactly 12 verification conditions; found $($VerificationMatches.Count)."
}

Write-Host "[PASS] Exactly ten security invariants." -ForegroundColor Green
Write-Host "[PASS] Exactly twelve verification conditions." -ForegroundColor Green

# ------------------------------------------------
# Protected artifact integrity
# ------------------------------------------------

foreach ($File in $Protected) {
    $After = (Get-FileHash $File -Algorithm SHA256).Hash

    if ($Before[$File] -ne $After) {
        throw "Protected artifact modified by generator: $File"
    }
}

Write-Host "[PASS] PM-0001 through PM-0005 were not modified by this generator." -ForegroundColor Green

# ------------------------------------------------
# Git diff check
# ------------------------------------------------

git diff --check -- $Path

if ($LASTEXITCODE -ne 0) {
    throw "git diff --check failed."
}

Write-Host "[PASS] git diff --check." -ForegroundColor Green

# ------------------------------------------------
# Final artifact information
# ------------------------------------------------

Write-Host ""
Write-Host "--- PM-0006 FILE ---" -ForegroundColor Cyan

Get-Item $Path |
    Select-Object Name, Length

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " PM-0006 SECURITY MATHEMATICS COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan