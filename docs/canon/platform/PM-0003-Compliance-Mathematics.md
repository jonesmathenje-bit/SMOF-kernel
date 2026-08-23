# PM-0003 — Compliance Mathematics

**Document ID:** PM-0003
**Document Type:** Platform Mathematical Canon
**Title:** Compliance Mathematics
**Status:** Canonical
**Version:** 1.0
**Parent Model:** PM-0001 — Platform Mathematical Model
**Previous Platform Artifact:** PM-0002 — Multi-Tenant Mathematics
**Domain:** SMOF Platform Mathematics
**Normative:** Yes

## 1. Purpose

This document defines the mathematical model for compliance within the SMOF platform.

Compliance is modeled as a set of formally verifiable constraints over platform states, subjects, resources, operations, policies, evidence, and transitions.

The purpose of this model is to establish a mathematical basis for determining whether a platform state or transition satisfies an applicable compliance policy.

## 2. Dependencies

This artifact depends on:

- PM-0001 — Platform Mathematical Model
- PM-0002 — Multi-Tenant Mathematics
- SRM-0001 — State Runtime Model, where applicable
- SRM-0002 — Runtime Transition
- The SMOF mathematical entity and operator contracts

PM-0003 specializes platform state and transition mathematics for compliance constraints.

## 3. Compliance Universe

Let

\[
\mathcal{C}
\]

be the universe of compliance requirements.

A compliance requirement is represented by

\[
c\in\mathcal{C}.
\]

Let

\[
\mathcal{S}
\]

be the subject universe,

\[
\mathcal{R}
\]

the resource universe,

\[
\mathcal{O}
\]

the operation universe, and

\[
\Sigma
\]

the platform state space.

A compliance policy is a function

\[
\pi:\Sigma\times\mathcal{C}\rightarrow\{0,1\}.
\]

The value

\[
\pi(\sigma,c)=1
\]

means that state \(\sigma\) satisfies requirement \(c\).

## 4. Requirement Model

Each requirement is represented as

\[
c=(id,scope,condition,evidence),
\]

where:

- \(id\) identifies the requirement;
- \(scope\) defines the objects or subjects to which it applies;
- \(condition\) defines the required property;
- \(evidence\) defines the information required to verify satisfaction.

The requirement is satisfied when its condition evaluates to true over the applicable state.

## 5. Compliance Predicate

Define the compliance predicate

\[
\operatorname{Compliant}(\sigma,c)
\]

such that

\[
\operatorname{Compliant}(\sigma,c)
=
\pi(\sigma,c).
\]

For a set of requirements

\[
C'\subseteq\mathcal{C},
\]

define aggregate compliance as

\[
\operatorname{Compliant}(\sigma,C')
=
\bigwedge_{c\in C'}
\operatorname{Compliant}(\sigma,c).
\]

Therefore the platform is compliant with \(C'\) exactly when every applicable requirement is satisfied.

## 6. Applicability

Not every requirement applies to every state.

Define the applicability predicate

\[
A:\Sigma\times\mathcal{C}\rightarrow\{0,1\}.
\]

Then

\[
A(\sigma,c)=1
\]

means that requirement \(c\) applies to state \(\sigma\).

Aggregate compliance therefore evaluates only applicable requirements:

\[
\operatorname{Compliant}_{A}(\sigma,C')
=
\bigwedge_{\substack{c\in C'\\A(\sigma,c)=1}}
\operatorname{Compliant}(\sigma,c).
\]

This distinction prevents an inapplicable requirement from being incorrectly interpreted as a compliance failure.

## 7. Compliance State

For a platform state \(\sigma\), define the compliance state vector

\[
\Gamma(\sigma)
=
(\gamma_1,\gamma_2,\ldots,\gamma_m)
\]

where each component corresponds to an applicable compliance requirement.

For requirement \(c_i\),

\[
\gamma_i
=
\operatorname{Compliant}(\sigma,c_i).
\]

Thus,

\[
\gamma_i\in\{0,1\}.
\]

A fully compliant state satisfies

\[
\Gamma(\sigma)
=
(1,1,\ldots,1)
\]

for all applicable requirements.

## 8. Compliance Transition

Let a runtime transition be

\[
T:\Sigma\rightarrow\Sigma.
\]

Given

\[
\sigma' = T(\sigma),
\]

the transition is compliance-preserving for requirement \(c\) when

\[
\operatorname{Compliant}(\sigma,c)=1
\Rightarrow
\operatorname{Compliant}(\sigma',c)=1.
\]

For a requirement set \(C'\),

\[
\operatorname{Compliant}_{A}(\sigma,C')=1
\Rightarrow
\operatorname{Compliant}_{A}(\sigma',C')=1
\]

for a compliance-preserving transition.

## 9. Compliance Violation

A violation exists when an applicable requirement is not satisfied:

\[
A(\sigma,c)=1
\land
\operatorname{Compliant}(\sigma,c)=0.
\]

Define the violation set:

\[
V(\sigma)
=
\{c\in\mathcal{C}
\mid
A(\sigma,c)=1
\land
\operatorname{Compliant}(\sigma,c)=0
\}.
\]

The state is compliant exactly when

\[
V(\sigma)=\varnothing.
\]

## 10. Evidence Model

Let

\[
\mathcal{E}
\]

be the evidence universe.

Define an evidence relation

\[
E\subseteq\mathcal{E}\times\mathcal{C}\times\Sigma.
\]

An evidence element \(e\) supports requirement \(c\) in state \(\sigma\) when

\[
(e,c,\sigma)\in E.
\]

Evidence does not itself imply compliance. It provides the observable basis from which the compliance predicate may be verified.

Therefore:

\[
\operatorname{Evidence}(e,c,\sigma)=1
\]

does not necessarily imply

\[
\operatorname{Compliant}(\sigma,c)=1.
\]

## 11. Auditability

Define the auditability predicate

\[
\operatorname{Auditable}(\sigma,c).
\]

A requirement is auditable when sufficient evidence exists to evaluate its compliance predicate.

Thus:

\[
\operatorname{Auditable}(\sigma,c)=1
\Rightarrow
\exists e\in\mathcal{E}:
(e,c,\sigma)\in E.
\]

Auditability and compliance are distinct properties.

A state may be compliant but insufficiently evidenced, or sufficiently evidenced but non-compliant.

## 12. Tenant-Scoped Compliance

In accordance with PM-0002, let

\[
t\in\mathcal{T}
\]

be a tenant.

Define the tenant compliance state

\[
\Gamma_t(\sigma).
\]

Tenant-specific compliance requirements operate over the tenant resource domain

\[
\mathcal{R}_t.
\]

For distinct tenants

\[
t_i\neq t_j,
\]

the compliance evaluation of tenant \(t_i\) must not implicitly incorporate private resources belonging exclusively to \(t_j\).

Therefore:

\[
\operatorname{Scope}(\Gamma_{t_i})
\cap
\mathcal{R}_{t_j}
=
\varnothing
\]

unless an explicit platform-level compliance relationship exists.

## 13. Compliance Invariants

### Invariant I1 — Determinate Compliance

Every applicable requirement has a determinate compliance value:

\[
A(\sigma,c)=1
\Rightarrow
\operatorname{Compliant}(\sigma,c)\in\{0,1\}.
\]

### Invariant I2 — Violation Consistency

\[
c\in V(\sigma)
\iff
A(\sigma,c)=1
\land
\operatorname{Compliant}(\sigma,c)=0.
\]

### Invariant I3 — Empty Violation Set

\[
V(\sigma)=\varnothing
\Rightarrow
\operatorname{Compliant}_{A}(\sigma,\mathcal{C})=1.
\]

### Invariant I4 — Evidence Separation

Evidence existence does not logically imply compliance:

\[
\operatorname{Evidence}(e,c,\sigma)=1
\not\Rightarrow
\operatorname{Compliant}(\sigma,c)=1.
\]

### Invariant I5 — Tenant Scope

Tenant-scoped compliance evaluation preserves the isolation constraints established by PM-0002.

### Invariant I6 — Transition Preservation

A transition explicitly classified as compliance-preserving must preserve every applicable compliance invariant.

## 14. Verification Conditions

### VC-01 — Requirement Definition

Every normative compliance requirement has a unique identifier and formally defined condition.

### VC-02 — Applicability

The system can determine whether a requirement applies to a given state.

### VC-03 — Compliance Evaluation

Every applicable requirement can be evaluated to a determinate Boolean value.

### VC-04 — Violation Detection

Every applicable unsatisfied requirement appears in the violation set.

### VC-05 — Evidence Traceability

Every auditable compliance assertion can be traced to sufficient evidence.

### VC-06 — Tenant Scope

Tenant-specific compliance evaluation cannot silently cross tenant boundaries.

### VC-07 — Transition Verification

Every state transition that claims compliance preservation can be mathematically evaluated against the applicable invariants.

### VC-08 — Audit Reproducibility

Given the same relevant state, requirement set, policy definitions, and evidence, the compliance evaluation is reproducible.

## 15. Relationship to SRM

PM-0003 defines the mathematical constraints governing compliance.

SRM defines the runtime state and transition semantics through which those constraints are realized.

The relationship is therefore:

\[
\text{Platform State}
\rightarrow
\text{SRM State}
\rightarrow
\text{Compliance Predicate}.
\]

For a transition

\[
\sigma' = T(\sigma),
\]

SRM determines whether the transition is valid as a runtime transition, while PM-0003 determines whether the resulting state satisfies applicable compliance constraints.

Thus:

\[
\boxed{
\text{Runtime Validity}
\land
\text{Compliance Validity}
}
\]

is required where a transition is subject to compliance constraints.

## 16. Canonical Boundary

PM-0003 defines compliance mathematically.

Specific regulations, standards, policies, retention periods, consent requirements, reporting obligations, or jurisdictional rules may be instantiated as concrete members of

\[
\mathcal{C}.
\]

The mathematical framework remains independent of any single regulation or jurisdiction.

## 17. Canonical Compliance Property

The principal platform compliance property is:

\[
\boxed{
V(\sigma)=\varnothing
}
\]

for every state required to satisfy the applicable compliance requirement set.

Equivalently:

\[
\boxed{
\forall c\in\mathcal{C},
\quad
A(\sigma,c)=1
\Rightarrow
\operatorname{Compliant}(\sigma,c)=1
}
\]

This is the normative compliance condition for the SMOF platform mathematical model.
