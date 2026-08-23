$ErrorActionPreference = "Stop"

$Repo = "C:\Users\BONOLO RAMOLLO\Documents\SMOF\smof-kernel"
$PlatformDir = Join-Path $Repo "docs\canon\platform"
$Path = Join-Path $PlatformDir "PM-0005-Observability-Mathematics.md"
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

if (-not (Test-Path (Join-Path $Repo ".git"))) {
    throw "Not a Git repository: $Repo"
}

Set-Location $Repo

$Branch = (git branch --show-current).Trim()

if ($Branch -ne "release/foundation-v1.0") {
    throw "Expected release/foundation-v1.0, detected: $Branch"
}

New-Item -ItemType Directory -Force -Path $PlatformDir | Out-Null

$Content = @'
# PM-0005 — Observability Mathematics

**Document ID:** PM-0005
**Document Type:** Platform Mathematical Canon
**Title:** Observability Mathematics
**Status:** Canonical
**Version:** 1.0
**Parent Model:** PM-0001 - Platform Mathematical Model
**Dependencies:** PM-0001 - Platform Mathematical Model; PM-0002 - Multi-Tenant Mathematics; PM-0003 - Compliance Mathematics; PM-0004 - Billing Mathematics; SRM-0002 - Runtime Transition
**Domain:** SMOF Platform Mathematics

## 1. Purpose

PM-0005 defines the mathematical model governing observability within the SMOF platform.

The model specifies how platform observations are represented, classified, aggregated, sampled, isolated by tenant, transitioned through runtime states, and verified.

The observability model covers metrics, events, traces, logs, signal aggregation, sampling, cardinality, state, and verification.

The purpose is to provide a deterministic mathematical boundary between runtime behavior and platform observability.

## 2. Dependencies

PM-0005 depends on:

1. PM-0001 for the platform mathematical universe.
2. PM-0002 for tenant identity and tenant isolation.
3. PM-0003 for compliance constraints on observable information.
4. PM-0004 for billing-related usage observations.
5. SRM-0002 for runtime transition semantics.

PM-0005 does not redefine those artifacts. It composes their constraints into the observability domain.

## 3. Observability Universe

Let:

\[
\mathcal{O}
\]

denote the observability universe.

An observation is represented as:

\[
o = (t,\tau,k,v,\lambda)
\]

where:

- \(t\) is time,
- \(\tau\) is tenant identity,
- \(k\) is observation kind,
- \(v\) is observation value,
- \(\lambda\) is associated metadata.

The observation set is:

\[
O = \{o_1,o_2,\ldots,o_n\} \subseteq \mathcal{O}
\]

The observation universe is partitioned by signal type:

\[
O = O_M \cup O_E \cup O_{Tr} \cup O_L
\]

where:

- \(O_M\) is the metric set,
- \(O_E\) is the event set,
- \(O_{Tr}\) is the trace set,
- \(O_L\) is the log set.

## 4. Signal Model

Define the observability signal space:

\[
\Sigma = \{M,E,Tr,L\}
\]

A signal classification function is:

\[
\sigma: O \rightarrow \Sigma
\]

with:

\[
\sigma(o) \in \{M,E,Tr,L\}
\]

Every accepted observation has exactly one canonical signal classification.

The signal model therefore satisfies:

\[
\forall o \in O,\quad |\{\sigma(o)\}| = 1
\]

## 5. Metric Model

A metric is:

\[
m=(t,\tau,n,v,u)
\]

where:

- \(t\) is timestamp,
- \(\tau\) is tenant,
- \(n\) is metric name,
- \(v\) is numeric value,
- \(u\) is unit.

The metric function is:

\[
M:\mathcal{T}\times\mathcal{N}\times\mathcal{V}\rightarrow\mathbb{R}
\]

A tenant-scoped metric set is:

\[
M_\tau = \{m\in O_M : tenant(m)=\tau\}
\]

Metrics must preserve their tenant association.

## 6. Event Model

An event is:

\[
e=(t,\tau,c,p)
\]

where:

- \(t\) is event time,
- \(\tau\) is tenant,
- \(c\) is event class,
- \(p\) is event payload.

The event classification function is:

\[
E:O_E\rightarrow\mathcal{C}
\]

where \(\mathcal{C}\) is the event-class universe.

An event is accepted only when its class and tenant identity are defined.

## 7. Trace Model

A trace is an ordered finite sequence of spans:

\[
Tr=(s_1,s_2,\ldots,s_n)
\]

with:

\[
s_i=(id,parent,t_0,t_1,\tau,a)
\]

where:

- \(id\) is span identity,
- \(parent\) is parent identity,
- \(t_0,t_1\) are start and end times,
- \(\tau\) is tenant,
- \(a\) is span metadata.

Trace ordering requires:

\[
t_0(s_i)\leq t_1(s_i)
\]

and parent-child relationships must remain within the same trace.

## 8. Log Model

A log record is:

\[
l=(t,\tau,\ell,m,c)
\]

where:

- \(t\) is timestamp,
- \(\tau\) is tenant,
- \(\ell\) is log level,
- \(m\) is message,
- \(c\) is contextual metadata.

The log set is:

\[
L_\tau=\{l\in O_L:tenant(l)=\tau\}
\]

Logs are observations and therefore remain subject to tenant and compliance constraints.

## 9. Aggregation Mathematics

Let \(O_\tau\) be the observations belonging to tenant \(\tau\).

For an aggregation interval \(B=[t_0,t_1)\):

\[
O_{\tau,B}=\{o\in O_\tau:t(o)\in B\}
\]

Define:

\[
Agg_f(O_{\tau,B})=f(O_{\tau,B})
\]

where \(f\) is a deterministic aggregation function.

For numeric metric values:

\[
Mean(X)=\frac{1}{|X|}\sum_{x\in X}x
\]

when \(|X|>0\).

Aggregation must not combine observations from different tenants.

## 10. Sampling Mathematics

Let:

\[
S_r(O)
\]

denote a sampling operator with sampling rate:

\[
0\leq r\leq1
\]

For probabilistic sampling:

\[
P(o\in S_r(O))=r
\]

for each eligible observation.

Required or compliance-critical observations may be assigned:

\[
r=1
\]

Sampling therefore cannot remove an observation that is classified as mandatory under the governing policy.

## 11. Cardinality Model

Let \(D\) be the set of distinct observable dimension tuples.

Cardinality is:

\[
Card(O)=|D|
\]

For a metric dimension function:

\[
d:M\rightarrow D
\]

the metric cardinality is:

\[
Card(M)=|\{d(m):m\in M\}|
\]

Cardinality limits are platform constraints and must be evaluated before an unbounded dimension set is accepted.

## 12. State Model

Define the observability state:

\[
S_{obs}=(A,Q,R,F)
\]

where:

- \(A\) is active signal state,
- \(Q\) is queued observation state,
- \(R\) is retained observation state,
- \(F\) is failed or rejected observation state.

The state space is:

\[
\mathcal{S}_{obs}
\]

An observation can therefore be represented as moving through:

\[
accepted\rightarrow queued\rightarrow retained
\]

or:

\[
accepted\rightarrow rejected
\]

## 13. Transition Model

Define the observability transition operator:

\[
\Theta_{obs}:
\mathcal{S}_{obs}\times O
\rightarrow
\mathcal{S}_{obs}
\]

A valid transition is:

\[
S_{i+1}=\Theta_{obs}(S_i,o)
\]

A transition is valid only if the observation satisfies identity, tenant, signal, compliance, and retention constraints.

The transition relation is:

\[
S_i\xrightarrow{o}S_{i+1}
\]

and must preserve all observability invariants.

## 14. Tenant Isolation

For tenants \(\tau_1\neq\tau_2\):

\[
O_{\tau_1}\cap O_{\tau_2}=\varnothing
\]

Tenant projection is defined as:

\[
\pi_\tau(O)=\{o\in O:tenant(o)=\tau\}
\]

For any tenant-scoped operation \(F\):

\[
F(\pi_\tau(O))\subseteq\pi_\tau(O')
\]

No observability operation may introduce an observation belonging to another tenant.

This establishes observability isolation independently of storage implementation.

## 15. Observability Invariants

### Invariant I1 — Tenant Identity

Every retained observation has exactly one tenant identity.

### Invariant I2 — Signal Classification

Every accepted observation has exactly one signal classification.

### Invariant I3 — Timestamp Validity

Every retained observation has a valid timestamp.

### Invariant I4 — Metric Validity

Every metric value belongs to the declared metric value domain.

### Invariant I5 — Trace Ordering

Every span satisfies:

\[
t_0\leq t_1
\]

### Invariant I6 — Tenant Isolation

For distinct tenants:

\[
O_{\tau_1}\cap O_{\tau_2}=\varnothing
\]

### Invariant I7 — Compliance Preservation

Observability processing cannot produce an output that violates PM-0003 constraints.

### Invariant I8 — Deterministic Aggregation

For identical input sets and identical aggregation parameters, aggregation produces identical results.

### Invariant I9 — State Validity

Every observability transition produces a state in \(\mathcal{S}_{obs}\).

### Invariant I10 — Runtime Consistency

Every runtime-observable transition is consistent with SRM transition semantics.

## 16. Verification Conditions

### VC-01 — Observation Identity

Verify that every retained observation has a tenant and signal identity.

### VC-02 — Signal Classification

Verify:

\[
\sigma(o)\in\Sigma
\]

for every accepted observation.

### VC-03 — Metric Domain

Verify that metric values satisfy their declared numeric domain.

### VC-04 — Event Classification

Verify that every event has a valid event class.

### VC-05 — Trace Ordering

Verify:

\[
t_0\leq t_1
\]

for every span.

### VC-06 — Log Integrity

Verify that every retained log has timestamp, tenant, level, and message fields.

### VC-07 — Aggregation Determinism

Verify deterministic equality for equal aggregation inputs.

### VC-08 — Sampling Constraint

Verify:

\[
0\leq r\leq1
\]

and that mandatory observations are not sampled out.

### VC-09 — Cardinality Constraint

Verify that observable dimension cardinality does not exceed the configured platform bound.

### VC-10 — Tenant Isolation

Verify:

\[
O_{\tau_1}\cap O_{\tau_2}=\varnothing
\]

for distinct tenants.

### VC-11 — Compliance Preservation

Verify that observability outputs satisfy PM-0003 requirements.

### VC-12 — Runtime Consistency

Verify that every observability transition is compatible with SRM transition semantics.

## 17. Relationship to PM-0002

PM-0002 defines the mathematical tenant universe.

PM-0005 applies tenant projection to all observability signals:

\[
O_\tau=\pi_\tau(O)
\]

The observability model therefore inherits tenant identity and isolation constraints from PM-0002.

PM-0005 does not redefine tenant identity.

## 18. Relationship to PM-0003

PM-0003 defines compliance mathematics.

PM-0005 treats compliance as an invariant over observable information.

Therefore:

\[
Compliance(O')=true
\]

must hold for every retained observability result \(O'\).

Observability cannot bypass compliance constraints through logging, tracing, metrics, events, aggregation, or sampling.

## 19. Relationship to PM-0004

PM-0004 defines billing mathematics.

Billing-relevant observations may be represented within:

\[
O_M\cup O_E
\]

but PM-0005 does not calculate invoices.

Usage observations supplied to PM-0004 must preserve tenant identity and observation integrity.

## 20. Relationship to SRM

SRM defines runtime transition mathematics.

PM-0005 observes runtime behavior without redefining runtime state.

For a runtime transition:

\[
S_i\xrightarrow{o}S_{i+1}
\]

the corresponding observability transition must remain compatible with the SRM transition relation.

Thus:

\[
\Theta_{obs}\circ\Theta_{runtime}
\]

must preserve the observability invariants defined by this document.

## 21. Canonical Boundary

PM-0005 canonically defines:

1. observability signals;
2. metric representation;
3. event representation;
4. trace representation;
5. log representation;
6. aggregation;
7. sampling;
8. cardinality;
9. observability state;
10. observability transitions;
11. tenant isolation;
12. observability invariants;
13. verification conditions.

Implementation-specific technologies, storage engines, dashboards, exporters, collectors, and visualization systems are outside this mathematical boundary.

The canonical model is implementation-independent.

'@

# Normalize content.
$Content = $Content -replace "`r`n", "`n"
$Content = $Content -replace "`r", "`n"
$Content = $Content -replace "[ \t]+(?=`n)", ""
$Content = $Content.TrimEnd("`n") + "`n"

[System.IO.File]::WriteAllText(
    $Path,
    $Content,
    $Utf8NoBom
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " SMOF PM-0005 OBSERVABILITY MATHEMATICS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "[PASS] Repository detected." -ForegroundColor Green
Write-Host "[PASS] Branch: $Branch" -ForegroundColor Green
Write-Host "[PASS] PM-0005 generated." -ForegroundColor Green

# Encoding verification.
$Bytes = [System.IO.File]::ReadAllBytes($Path)
$Text = [System.IO.File]::ReadAllText($Path, $Utf8NoBom)

$HasBom = $false

if ($Bytes.Length -ge 3) {
    $HasBom = (
        $Bytes[0] -eq 0xEF -and
        $Bytes[1] -eq 0xBB -and
        $Bytes[2] -eq 0xBF
    )
}

$HasCR = $Text.Contains("`r")
$HasFinalLF = $Text.EndsWith("`n")
$HasDoubleFinalLF = $Text.EndsWith("`n`n")

if ($HasBom) {
    throw "PM-0005 BOM detected."
}

if ($HasCR) {
    throw "PM-0005 contains CR characters."
}

if (-not $HasFinalLF) {
    throw "PM-0005 does not end with LF."
}

if ($HasDoubleFinalLF) {
    throw "PM-0005 contains multiple final LF characters."
}

Write-Host "[PASS] UTF-8 BOM absent." -ForegroundColor Green
Write-Host "[PASS] LF-only endings." -ForegroundColor Green
Write-Host "[PASS] Exactly one final LF." -ForegroundColor Green

Write-Host ""
Write-Host "--- CANONICAL SECTION AUDIT ---" -ForegroundColor Yellow

$Sections = @(
    "## 1. Purpose",
    "## 2. Dependencies",
    "## 3. Observability Universe",
    "## 4. Signal Model",
    "## 5. Metric Model",
    "## 6. Event Model",
    "## 7. Trace Model",
    "## 8. Log Model",
    "## 9. Aggregation Mathematics",
    "## 10. Sampling Mathematics",
    "## 11. Cardinality Model",
    "## 12. State Model",
    "## 13. Transition Model",
    "## 14. Tenant Isolation",
    "## 15. Observability Invariants",
    "## 16. Verification Conditions",
    "## 17. Relationship to PM-0002",
    "## 18. Relationship to PM-0003",
    "## 19. Relationship to PM-0004",
    "## 20. Relationship to SRM",
    "## 21. Canonical Boundary"
)

foreach ($Section in $Sections) {
    if ($Text.Contains($Section)) {
        Write-Host "[PASS] $Section" -ForegroundColor Green
    }
    else {
        throw "Missing canonical section: $Section"
    }
}

$InvariantCount = ([regex]::Matches(
    $Text,
    "### Invariant I[0-9]+"
)).Count

$VCCount = ([regex]::Matches(
    $Text,
    "### VC-[0-9]+"
)).Count

if ($InvariantCount -ne 10) {
    throw "Expected 10 invariants; detected $InvariantCount."
}

if ($VCCount -ne 12) {
    throw "Expected 12 verification conditions; detected $VCCount."
}

Write-Host "[PASS] Exactly ten observability invariants." -ForegroundColor Green
Write-Host "[PASS] Exactly twelve verification conditions." -ForegroundColor Green

git diff --check -- $Path

if ($LASTEXITCODE -ne 0) {
    throw "git diff --check failed."
}

Write-Host "[PASS] git diff --check." -ForegroundColor Green

Write-Host ""
Write-Host "--- PM-0005 FILE ---" -ForegroundColor Cyan

Get-Item $Path |
    Select-Object Name, Length

Write-Host ""
Write-Host "[PASS] PM-0001 through PM-0004 were not modified by this generator." -ForegroundColor Green
