# PM-0002 - Multi-Tenant Mathematics

**Document ID:** PM-0002
**Document Type:** Platform Mathematical Canon
**Title:** Multi-Tenant Mathematics
**Status:** Canonical
**Version:** 1.0
**Parent Model:** PM-0001 - Platform Mathematical Model
**Previous Platform Artifact:** None
**Domain:** SMOF Platform Mathematics
**Normative:** Yes

## 1. Purpose

This document defines the mathematical model for multi-tenancy within the SMOF platform.

The model establishes mathematical boundaries between tenants, tenant-owned resources, subjects, operations, state, and platform transitions.

The objective is to ensure that tenant isolation is represented as a formal property rather than as an implementation convention.

## 2. Dependencies

This artifact depends on:

- PM-0001 - Platform Mathematical Model
- SRM-0001 - State Runtime Model, where applicable
- SRM-0002 - Runtime Transition
- SMOF mathematical entity and operator contracts

PM-0002 does not replace the runtime transition mathematics defined by SRM. It specializes those mathematical structures for tenant isolation.

## 3. Mathematical Universe

Let the platform universe be

U.

Let the tenant set be

T = {t1, t2, ..., tn}.

Let the resource universe be

R.

Let the subject universe be

S.

Let the operation universe be

O.

For each tenant t in T, define its resource domain as

R_t subset R.

Its subject domain is

S_t subset S.

Its operation domain is represented by

O_t subset O.

## 4. Tenant Ownership Function

Define the ownership function

omega : R -> T union {bottom}

where omega(r) = t means resource r belongs to tenant t.

The value omega(r) = bottom means that the resource is platform-scoped rather than tenant-owned.

Therefore,

R_t = {r in R | omega(r) = t}.

## 5. Tenant Identity Function

Define

tau : S -> T union {bottom}

where tau(s) = t identifies subject s as belonging to tenant t.

A subject with tau(s) = bottom is platform-scoped.

## 6. Tenant Isolation

For distinct tenants

t_i, t_j in T,

t_i != t_j,

tenant-owned resource domains must satisfy

R_t_i intersection R_t_j = empty-set.

This is the fundamental resource-isolation invariant.

Likewise, tenant subject domains satisfy

S_t_i intersection S_t_j = empty-set.

These relations establish logical separation even when multiple tenants share the same physical infrastructure.

## 7. Tenant Context

Define a tenant context as

C = (t, s, r, o)

where:

- t is the active tenant;
- s is the acting subject;
- r is the target resource;
- o is the requested operation.

A context is tenant-consistent when

tau(s) = t

and, where r is not bottom,

omega(r) = t.

## 8. Cross-Tenant Access

For

t_i != t_j,

a direct operation from a subject belonging to t_i against a resource belonging to t_j is invalid unless an explicitly defined platform-level policy authorizes such interaction.

Formally, absent an explicit cross-tenant policy X,

tau(s) = t_i
and
omega(r) = t_j
and
t_i != t_j

implies

Allow(s,r,o) = 0.

## 9. Tenant State

Let the state of tenant t at runtime instant k be

sigma_t(k).

The global platform state is

Sigma(k) = {sigma_t(k) | t in T} union sigma_P(k),

where sigma_P(k) represents platform-scoped state.

A tenant-local transition is represented by

sigma_t(k+1) = F_t(sigma_t(k), o).

A valid tenant-local transition must not modify another tenant's isolated state.

Thus, for

t_i != t_j,

a transition generated exclusively by t_i satisfies

Delta_t_i sigma_t_j = 0

unless an explicit platform-mediated cross-tenant transition exists.

## 10. Tenant Transition Model

Define the transition operator

Theta_t : Sigma x O -> Sigma.

For a tenant-local operation o_t,

Theta_t(Sigma, o_t) = Sigma'.

The operation is valid only if:

ValidContext(C) = 1

and

Authorized(C) = 1.

The transition therefore satisfies

Sigma' = Theta_t(Sigma, o_t).

## 11. Tenant Isolation Invariants

### Invariant I1 - Resource Separation

t_i != t_j

implies

R_t_i intersection R_t_j = empty-set.

### Invariant I2 - Subject Separation

t_i != t_j

implies

S_t_i intersection S_t_j = empty-set.

### Invariant I3 - Context Consistency

For tenant-local access:

tau(s) = t = omega(r).

### Invariant I4 - State Isolation

A tenant-local transition for t_i cannot alter isolated tenant state belonging to t_j:

t_i != t_j

implies

Delta_t_i sigma_t_j = 0.

### Invariant I5 - Determinate Ownership

Every tenant-owned resource has exactly one tenant owner:

r in R_t

implies

omega(r) = t.

## 12. Verification Conditions

### VC-01 - Tenant Identity

Every tenant-scoped subject resolves to exactly one tenant.

### VC-02 - Resource Ownership

Every tenant-scoped resource resolves to exactly one tenant.

### VC-03 - Context Validation

Every tenant-scoped operation validates subject, tenant, and resource consistency before transition.

### VC-04 - Isolation

An operation authorized for tenant t_i cannot modify isolated state belonging to t_j, where

t_i != t_j.

### VC-05 - Cross-Tenant Policy

Any permitted cross-tenant operation must be represented by an explicit policy relation rather than by implicit identifier overlap.

### VC-06 - State Preservation

Tenant-local transitions preserve all tenant isolation invariants.

## 13. Relationship to SRM

PM-0002 defines the platform-domain mathematics of tenant separation.

SRM defines the mathematical runtime behavior of state and transitions.

Therefore:

PM-0002 -> tenant-domain constraints

while

SRM -> runtime state-transition semantics.

A tenant transition is valid only when both the platform constraints and runtime transition rules are satisfied.

## 14. Canonical Boundary

PM-0002 defines the mathematical meaning of tenant separation, ownership, context, and isolation.

Implementation technologies such as databases, namespaces, containers, IAM systems, network segmentation, or application-level filters are implementation mechanisms and do not alter the mathematical definitions in this document.

## 15. Canonical Invariant

The principal multi-tenant safety property is:

t_i != t_j

implies

Delta_t_i sigma_t_j = 0

unless an explicitly authorized platform-mediated cross-tenant transition is defined.

This invariant is normative for the SMOF platform mathematical model.
