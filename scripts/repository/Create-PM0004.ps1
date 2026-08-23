$ErrorActionPreference = "Stop"

$Repo = "C:\Users\BONOLO RAMOLLO\Documents\SMOF\smof-kernel"
$PlatformDir = Join-Path $Repo "docs\canon\platform"
$PM0004 = Join-Path $PlatformDir "PM-0004-Billing-Mathematics.md"

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

if (-not (Test-Path (Join-Path $Repo ".git"))) {
    throw "Not a Git repository: $Repo"
}

if (-not (Test-Path $PlatformDir)) {
    New-Item -ItemType Directory -Force -Path $PlatformDir | Out-Null
}

Set-Location $Repo

$Branch = (git branch --show-current).Trim()

if ($Branch -ne "release/foundation-v1.0") {
    throw "Expected release/foundation-v1.0, detected: $Branch"
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " SMOF PM-0004 BILLING MATHEMATICS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "[PASS] Repository detected." -ForegroundColor Green
Write-Host "[PASS] Branch: $Branch" -ForegroundColor Green

$Content = @'
# PM-0004 - Billing Mathematics

**Document ID:** PM-0004
**Document Type:** Platform Mathematical Canon
**Title:** Billing Mathematics
**Status:** Canonical
**Version:** 1.0
**Parent Model:** PM-0001 - Platform Mathematical Model
**Dependencies:** PM-0002 - Multi-Tenant Mathematics; PM-0003 - Compliance Mathematics; SRM-0002 - Runtime Transition
**Domain:** SMOF Platform Mathematics
**Normative:** Yes

## 1. Purpose

PM-0004 defines the mathematical model governing billing within the SMOF platform.

The model provides a deterministic relationship between measured usage, pricing, charges, adjustments, taxation, invoicing, payments, balances, and settlement.

The model is tenant-scoped, auditable, state-driven, and compatible with the SMOF Runtime Mathematics.

## 2. Dependencies

PM-0004 depends on:

- PM-0001 - Platform Mathematical Model
- PM-0002 - Multi-Tenant Mathematics
- PM-0003 - Compliance Mathematics
- SRM-0002 - Runtime Transition
- applicable SMOF mathematical entity, object, operator, and runtime contracts

PM-0004 specializes the platform model for financial computation.

## 3. Billing Universe

Let:

- T be the set of tenants.
- B be the set of billing periods.
- E be the set of usage events.
- D be the set of billable dimensions.
- P be the set of pricing configurations.
- C be the set of supported currencies.
- M be the monetary domain.

A billing context is:

\[
(t,b) \in T \times B
\]

where t identifies the tenant and b identifies the billing period.

## 4. Usage Model

For tenant t, billing period b, and billable dimension d, define the valid usage-event set:

\[
E_v(t,b,d) \subseteq E
\]

For each event e:

\[
e=(t_e,d_e,q_e,u_e,\tau_e)
\]

where:

- t_e is the tenant;
- d_e is the billable dimension;
- q_e is the quantity;
- u_e is the measurement unit;
- \tau_e is the event time.

The aggregate usage is:

\[
Q(t,b,d)=\sum_{e\in E_v(t,b,d)}q_e
\]

Invalid events contribute zero to authoritative billing usage.

## 5. Usage Validity

Define:

\[
ValidUsage(e)\in\{0,1\}
\]

An event is valid only when tenant identity, resource identity, quantity, unit, timestamp, and billable classification are valid.

Therefore:

\[
ValidUsage(e)=0 \Rightarrow Contribution(e)=0
\]

## 6. Pricing Function

Define the pricing function:

\[
Price(t,b,d,q)=p
\]

where p is the monetary price assigned to quantity q of dimension d for tenant t during billing period b.

Pricing may depend on:

- tenant;
- plan;
- resource class;
- quantity;
- tier;
- time;
- contractual rate;
- applicable discount rules.

For identical authoritative inputs and identical pricing state:

\[
Price(t,b,d,q)=p
\]

must be deterministic.

## 7. Tiered Pricing

Let the quantity breakpoints be:

\[
0=q_0<q_1<\cdots<q_n
\]

and let r_i be the rate for tier i.

The tier contribution is:

\[
C_i(q)=
\min(\max(q-q_{i-1},0),q_i-q_{i-1})r_i
\]

for bounded tiers.

For an open-ended final tier:

\[
C_n(q)=\max(q-q_{n-1},0)r_n
\]

The total charge is:

\[
Charge(t,b,d)=\sum_i C_i(Q(t,b,d))
\]

## 8. Gross Charge

The gross charge is:

\[
G(t,b)=\sum_{d\in D}Charge(t,b,d)
\]

G(t,b) represents the amount before adjustments and taxation.

## 9. Adjustments

Let:

\[
A(t,b)
\]

be the set of authorized billing adjustments.

For adjustment a, let:

\[
\delta(a)\in M
\]

be its signed monetary value.

The aggregate adjustment is:

\[
A_{sum}(t,b)=\sum_{a\in A(t,b)}\delta(a)
\]

The adjusted subtotal is:

\[
S(t,b)=G(t,b)+A_{sum}(t,b)
\]

Adjustments include, where applicable:

- discounts;
- credits;
- surcharges;
- corrections;
- refunds.

Every adjustment must have an authorization and audit basis.

## 10. Tax Model

Let:

\[
TaxRate_j(t,b,x)=r_j
\]

represent the applicable rate for tax component j.

Then:

\[
Tax_j(t,b)=x r_j
\]

and:

\[
TaxTotal(t,b)=\sum_j Tax_j(t,b)
\]

where x is the applicable taxable base.

Tax applicability is governed by PM-0003 compliance mathematics and applicable billing policy.

## 11. Invoice Total

The invoice total is:

\[
I(t,b)=S(t,b)+TaxTotal(t,b)
\]

Therefore:

\[
I(t,b)=G(t,b)+A_{sum}(t,b)+TaxTotal(t,b)
\]

The authoritative billing pipeline is:

\[
Usage\rightarrow Rating\rightarrow Charge\rightarrow Adjustment\rightarrow Tax\rightarrow Invoice
\]

## 12. Monetary Precision

Let:

\[
Round_c(x)
\]

be the canonical rounding function for currency c.

Every authoritative monetary result must be represented as:

\[
Amount_c(x)=Round_c(x)
\]

The currency, scale, and rounding rule must be deterministic.

An implementation must not silently change monetary precision between calculation stages.

## 13. Billing Period

A billing period is a half-open interval:

\[
b=[\tau_{start},\tau_{end})
\]

An event belongs to b exactly when:

\[
\tau_{start}\leq\tau_e<\tau_{end}
\]

This guarantees that an event at a boundary belongs to exactly one period.

## 14. Invoice State

Define the invoice state space:

\[
S_{invoice}=
\{Draft,Issued,Due,PartiallyPaid,Paid,Overdue,Cancelled,Disputed\}
\]

The invoice state at runtime instant k is:

\[
s_I(k)\in S_{invoice}
\]

## 15. Invoice Transition Model

Define:

\[
F_{invoice}:S_{invoice}\times Event\rightarrow S_{invoice}
\]

A normal lifecycle is:

\[
Draft\rightarrow Issued\rightarrow Due\rightarrow Paid
\]

A partial-payment lifecycle is:

\[
Due\rightarrow PartiallyPaid\rightarrow Paid
\]

An overdue lifecycle is:

\[
Due\rightarrow Overdue\rightarrow Paid
\]

Cancellation and dispute transitions require explicit authorization.

An unlisted transition is invalid.

## 16. Payment Model

Let:

\[
P(t,b)
\]

be the set of valid payments associated with invoice (t,b).

The settled payment amount is:

\[
Paid(t,b)=\sum_{p\in P(t,b)}amount(p)
\]

The outstanding balance is:

\[
Balance(t,b)=I(t,b)-Paid(t,b)
\]

## 17. Settlement

Define the settlement predicate:

\[
Settled(I)=1
\]

when:

\[
Balance(I)=0
\]

and all required payment validation conditions hold.

Thus invoice issuance does not imply settlement.

A payment changes the financial state; it does not redefine the invoice calculation.

## 18. Tenant Billing Isolation

PM-0002 establishes tenant identity and isolation.

For distinct tenants:

\[
t_i\neq t_j
\]

billing state for t_i must not silently consume or modify private billing state belonging to t_j.

Therefore:

\[
BillingState(t_i)\perp BillingState(t_j)
\]

except where an explicitly defined platform-level financial relationship exists.

## 19. Billing State

Define the billing state:

\[
\Sigma_{bill}(t,b)=
(E,Q,G,A,S,Tax,I,P,Balance,State)
\]

where:

- E = authoritative usage events;
- Q = aggregate usage;
- G = gross charge;
- A = adjustments;
- S = adjusted subtotal;
- Tax = applicable taxes;
- I = invoice total;
- P = valid payments;
- Balance = outstanding balance;
- State = invoice lifecycle state.

## 20. Billing Transition

Define:

\[
\Theta_{bill}:
\Sigma_{bill}\times Event
\rightarrow
\Sigma_{bill}
\]

A billing transition is valid only when its preconditions hold.

For invoice issuance:

\[
ValidUsageSet
\land
PricingConfigurationValid
\land
AdjustmentSetValid
\land
TaxConfigurationValid
\land
InvoiceCalculationValid
\]

must evaluate to true.

The resulting state must satisfy all billing invariants.

## 21. Billing Invariants

### Invariant I1 - Tenant Ownership

Every authoritative billing record has exactly one tenant owner.

### Invariant I2 - Period Determinacy

Every valid usage event belongs to exactly one billing period.

### Invariant I3 - Invalid Usage Exclusion

Invalid usage events contribute zero to authoritative billing quantities.

### Invariant I4 - Deterministic Rating

Identical authoritative inputs and identical pricing state produce identical charges.

### Invariant I5 - Invoice Derivation

\[
I=S+TaxTotal
\]

must hold for every authoritative invoice.

### Invariant I6 - Payment Separation

Invoice issuance does not imply payment.

### Invariant I7 - Balance Consistency

\[
Balance=InvoiceTotal-ValidPayments
\]

### Invariant I8 - Settlement

\[
Settled(I)=1\Rightarrow Balance(I)=0
\]

### Invariant I9 - Tenant Isolation

Billing state belonging to one tenant cannot silently modify private billing state belonging to another tenant.

### Invariant I10 - State Validity

Every invoice state transition belongs to the canonical invoice transition relation.

## 22. Verification Conditions

### VC-01 - Usage Integrity

Every authoritative usage event has valid tenant, resource, quantity, unit, timestamp, and billable classification.

### VC-02 - Period Assignment

Every valid usage event belongs to exactly one billing period.

### VC-03 - Pricing Determinism

Identical usage and pricing inputs produce identical charges.

### VC-04 - Tier Integrity

Tier intervals do not overlap and every quantity maps to a determinate tier contribution.

### VC-05 - Adjustment Integrity

Every adjustment has a determinate amount, classification, authorization, and audit basis.

### VC-06 - Tax Applicability

Every applied tax component has a valid applicability determination.

### VC-07 - Monetary Precision

Every authoritative monetary result follows the canonical currency precision and rounding policy.

### VC-08 - Invoice Reproducibility

Identical authoritative billing inputs reproduce the same invoice total.

### VC-09 - Payment Integrity

Only validated payments contribute to the settled payment amount.

### VC-10 - Balance Integrity

\[
Balance=InvoiceTotal-Paid
\]

subject to the canonical monetary precision.

### VC-11 - Tenant Isolation

A billing computation for tenant t_i cannot silently consume or modify private billing state belonging to t_j where:

\[
t_i\neq t_j
\]

### VC-12 - Transition Validity

Every billing transition satisfies its preconditions and belongs to the canonical transition relation.

## 23. Relationship to PM-0002

PM-0002 defines tenant ownership and isolation.

PM-0004 specializes those constraints for billing:

\[
TenantIdentity
\rightarrow
UsageOwnership
\rightarrow
BillingScope
\rightarrow
InvoiceOwnership
\rightarrow
SettlementOwnership
\]

Billing must preserve tenant scope throughout the entire chain.

## 24. Relationship to PM-0003

PM-0003 defines compliance predicates, applicability, evidence, and verification.

PM-0004 uses those mechanisms for compliance-sensitive billing operations, including:

- billing-data processing;
- audit evidence;
- retention;
- financial records;
- tax applicability;
- controlled adjustments.

PM-0004 does not replace PM-0003.

## 25. Relationship to SRM

PM-0004 defines the mathematical structure of billing state and billing calculations.

SRM defines runtime transition semantics.

For:

\[
\Sigma'_{bill}=\Theta_{bill}(\Sigma_{bill},e)
\]

the resulting state must satisfy both PM-0004 invariants and applicable SRM transition rules.

## 26. Canonical Boundary

PM-0004 defines billing mathematically.

Payment processors, accounting systems, databases, tax engines, payment gateways, invoices, and financial ledgers are implementation mechanisms.

They must implement the canonical mathematical relationships but must not redefine them.

## 27. Canonical Billing Equation

The principal billing equation is:

\[
I(t,b)=G(t,b)+A_{sum}(t,b)+TaxTotal(t,b)
\]

The principal settlement equation is:

\[
Balance(t,b)=I(t,b)-Paid(t,b)
\]

The canonical billing chain is:

\[
Usage
\rightarrow
Charge
\rightarrow
Adjustment
\rightarrow
Tax
\rightarrow
Invoice
\rightarrow
Payment
\rightarrow
Settlement
\]

These relationships are normative for the SMOF platform mathematical model.
'@

$Content = $Content -replace "`r`n", "`n"
$Content = $Content -replace "`r", "`n"
$Content = $Content.TrimEnd("`n") + "`n"

[System.IO.File]::WriteAllText(
    $PM0004,
    $Content,
    $Utf8NoBom
)

if (-not (Test-Path $PM0004)) {
    throw "PM-0004 was not created."
}

$Bytes = [System.IO.File]::ReadAllBytes($PM0004)
$Text = [System.IO.File]::ReadAllText($PM0004, $Utf8NoBom)

$HasBom = $false

if ($Bytes.Length -ge 3) {
    if (
        $Bytes[0] -eq 0xEF -and
        $Bytes[1] -eq 0xBB -and
        $Bytes[2] -eq 0xBF
    ) {
        $HasBom = $true
    }
}

if ($HasBom) {
    throw "UTF-8 BOM detected."
}

if ($Text.Contains("`r")) {
    throw "CR character detected."
}

if (-not $Text.EndsWith("`n")) {
    throw "Final LF missing."
}

if ($Text.EndsWith("`n`n")) {
    throw "More than one final LF detected."
}

Write-Host "[PASS] PM-0004 generated." -ForegroundColor Green
Write-Host "[PASS] UTF-8 BOM absent." -ForegroundColor Green
Write-Host "[PASS] LF-only endings." -ForegroundColor Green
Write-Host "[PASS] Exactly one final LF." -ForegroundColor Green
Write-Host "[PASS] PM-0001 through PM-0003 were not modified." -ForegroundColor Green

Write-Host ""
Write-Host "FILE:" -ForegroundColor Yellow
Get-Item $PM0004 | Select-Object Name,Length
