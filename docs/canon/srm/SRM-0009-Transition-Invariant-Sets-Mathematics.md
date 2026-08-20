# SRM-0009 — Transition Invariant Sets Mathematics

**Document ID:** SRM-0009
**Title:** Transition Invariant Sets Mathematics
**System:** SMOF Kernel
**Domain:** State Transition Mathematics
**Status:** Canonical Draft
**Predecessors:** SRM-0002, SRM-0003, SRM-0004, SRM-0005, SRM-0006, SRM-0007, SRM-0008

---

## 1. Purpose

SRM-0009 defines the mathematical structure of invariant sets for SMOF state transitions.

The specification extends the reachability, orbit, periodicity, and recurrence mathematics established by SRM-0007 and SRM-0008.

An invariant set identifies a collection of states whose transition dynamics remain within that collection.

---

## 2. Transition System

Let

\[
\mathcal{S}=(S,P)
\]

be a deterministic state-transition system, where

\[
P:S\to S.
\]

For a subset

\[
A\subseteq S,
\]

the image of \(A\) under \(P\) is

\[
P(A)=\{P(x):x\in A\}.
\]

---

## 3. Forward Invariant Set

A set \(A\subseteq S\) is forward invariant under \(P\) if

\[
P(A)\subseteq A.
\]

Equivalently,

\[
\forall x\in A,\quad P(x)\in A.
\]

Thus, once a state enters \(A\), every subsequent forward transition remains in \(A\).

---

## 4. Strong Invariance

A set \(A\subseteq S\) is strongly invariant if

\[
P(A)=A.
\]

Strong invariance therefore implies forward invariance:

\[
P(A)=A
\Longrightarrow
P(A)\subseteq A.
\]

---

## 5. Backward Invariance

For a transition map admitting an inverse, a set \(A\subseteq S\) is backward invariant when

\[
P^{-1}(A)\subseteq A.
\]

If both forward and backward invariance hold, then

\[
P(A)=A.
\]

---

## 6. Pointwise Characterization

A set \(A\) is forward invariant if and only if

\[
x\in A
\Longrightarrow
P(x)\in A.
\]

By induction,

\[
x\in A
\Longrightarrow
P^n(x)\in A
\]

for every

\[
n\in\mathbb{N}_0.
\]

Hence

\[
A
\supseteq
P(A)
\supseteq
P^2(A)
\supseteq\cdots.
\]

---

## 7. Orbit Characterization

For every

\[
x\in A,
\]

forward invariance implies

\[
\mathcal{O}_P^+(x)\subseteq A.
\]

Since

\[
\operatorname{Reach}_P(x)
=
\mathcal{O}_P^+(x),
\]

we obtain

\[
\operatorname{Reach}_P(x)\subseteq A.
\]

Therefore a forward-invariant set contains the complete forward orbit of every one of its states.

---

## 8. Reachability Criterion

A set \(A\subseteq S\) is forward invariant if and only if

\[
\forall x\in A,\quad
\operatorname{Reach}_P(x)\subseteq A.
\]

This establishes the connection between invariant-set mathematics and the reachability mathematics of SRM-0007.

---

## 9. Union of Invariant Sets

If

\[
\{A_i\}_{i\in I}
\]

is a family of forward-invariant subsets of \(S\), then

\[
\bigcup_{i\in I}A_i
\]

is forward invariant.

Indeed,

\[
P\left(\bigcup_{i\in I}A_i\right)
=
\bigcup_{i\in I}P(A_i)
\subseteq
\bigcup_{i\in I}A_i.
\]

---

## 10. Intersection of Invariant Sets

If

\[
\{A_i\}_{i\in I}
\]

is a family of forward-invariant subsets, then

\[
\bigcap_{i\in I}A_i
\]

is forward invariant.

For

\[
x\in\bigcap_{i\in I}A_i,
\]

we have

\[
x\in A_i
\]

for every \(i\), and therefore

\[
P(x)\in A_i
\]

for every \(i\). Hence

\[
P(x)\in\bigcap_{i\in I}A_i.
\]

---

## 11. Invariant Hull

For an arbitrary set

\[
A\subseteq S,
\]

define its forward invariant hull by

\[
\operatorname{InvHull}_P(A)
=
\bigcup_{n\geq0}P^n(A).
\]

This is the smallest forward-invariant set containing \(A\).

---

## 12. Minimality of the Invariant Hull

If

\[
A\subseteq B
\]

and \(B\) is forward invariant, then

\[
\operatorname{InvHull}_P(A)
\subseteq B.
\]

Therefore

\[
\operatorname{InvHull}_P(A)
\]

is the least forward-invariant extension of \(A\).

---

## 13. Fixed Points as Invariant Sets

For a fixed point

\[
P(x)=x,
\]

the singleton

\[
\{x\}
\]

is strongly invariant because

\[
P(\{x\})=\{x\}.
\]

Thus every fixed point determines a minimal nonempty strongly invariant set.

---

## 14. Periodic Orbits as Invariant Sets

If

\[
P^k(x)=x
\]

for some

\[
k\geq1,
\]

then the periodic orbit

\[
\mathcal{O}_P(x)
=
\{P^n(x):n\in\mathbb{Z}\}
\]

is strongly invariant whenever \(P\) is invertible on the orbit.

In the finite-period case,

\[
P(\mathcal{O}_P(x))
=
\mathcal{O}_P(x).
\]

Thus periodicity produces invariant dynamical structure.

---

## 15. Trapping Sets

A set

\[
A\subseteq S
\]

is a trapping set when

\[
P(A)\subseteq A.
\]

Therefore every trapping set is forward invariant.

For

\[
x\in A,
\]

we obtain

\[
P^n(x)\in A
\]

for every

\[
n\geq0.
\]

---

## 16. Invariant Subsystem

If \(A\subseteq S\) is forward invariant, then the restriction

\[
P|_A:A\to A
\]

is a valid state-transition operator on \(A\).

Consequently,

\[
(S,P)
\]

induces the subsystem

\[
(A,P|_A).
\]

---

## 17. Invariant Set Family

Define

\[
\operatorname{Inv}(P)
=
\{A\subseteq S:P(A)\subseteq A\}.
\]

The collection of invariant sets is closed under arbitrary unions and intersections.

Thus invariant sets form a complete lattice under set inclusion.

---

## 18. Ordering

For

\[
A,B\in\operatorname{Inv}(P),
\]

define

\[
A\preceq B
\iff
A\subseteq B.
\]

The meet is

\[
A\wedge B=A\cap B
\]

and the join is

\[
A\vee B=A\cup B.
\]

---

## 19. Runtime Invariant

A runtime invariant is a predicate

\[
I:S\to\{\mathrm{true},\mathrm{false}\}
\]

such that

\[
I(x)=\mathrm{true}
\Longrightarrow
I(P(x))=\mathrm{true}.
\]

The corresponding invariant set is

\[
A_I
=
\{x\in S:I(x)=\mathrm{true}\}.
\]

Then

\[
P(A_I)\subseteq A_I.
\]

---

## 20. Inductive Preservation

If

\[
I(x_0)=\mathrm{true}
\]

and

\[
I(x)\Rightarrow I(P(x)),
\]

then

\[
I(P^n(x_0))=\mathrm{true}
\]

for every

\[
n\in\mathbb{N}_0.
\]

This establishes invariant preservation by mathematical induction.

---

## 21. Transition Safety

Let

\[
A_{\mathrm{safe}}\subseteq S
\]

be a safety region.

The transition system is safe relative to \(A_{\mathrm{safe}}\) when

\[
x_0\in A_{\mathrm{safe}}
\]

implies

\[
P^n(x_0)\in A_{\mathrm{safe}}
\]

for every

\[
n\geq0.
\]

Therefore safety is an invariant-set property.

---

## 22. Transition Violation

A transition violates an invariant set \(A\) when

\[
x\in A
\]

but

\[
P(x)\notin A.
\]

Equivalently,

\[
P(A)\nsubseteq A.
\]

---

## 23. Invariance Under Conjugacy

Let

\[
Q=\phi\circ P\circ\phi^{-1}.
\]

If

\[
A\subseteq S
\]

is invariant under \(P\), then

\[
\phi(A)
\]

is invariant under \(Q\).

Indeed,

\[
Q(\phi(A))
=
\phi(P(A))
\subseteq
\phi(A).
\]

Hence invariant-set structure is preserved by transition conjugacy.

---

## 24. Invariant-Set Correspondence

Under a bijective conjugacy

\[
\phi:S\to T,
\]

the mapping

\[
A\mapsto\phi(A)
\]

establishes a correspondence between invariant subsets of the two transition systems.

Therefore invariant-set structure is preserved under conjugacy.

---

## 25. Transition Composition

For a sequence

\[
P_{0:n}
=
P_{n-1}\circ\cdots\circ P_0,
\]

if

\[
P_i(A)\subseteq A
\]

for every \(i\), then

\[
P_{0:n}(A)\subseteq A.
\]

Thus invariance composes across a transition sequence.

---

## 26. Canonical Principle

The canonical invariant-set principle of SMOF State Transition Mathematics is

\[
\boxed{
A\subseteq S
\text{ is forward invariant under }P
\iff
P(A)\subseteq A
}
\]

with strong invariance given by

\[
\boxed{
P(A)=A.
}
\]

---

## 27. Relationship to Previous SRM Specifications

SRM-0007 establishes reachability and orbit mathematics.

SRM-0008 establishes periodicity and recurrence mathematics.

SRM-0009 extends these structures by defining invariant subsets of the state space.

The progression is

\[
\text{Reachability}
\to
\text{Orbit}
\to
\text{Recurrence}
\to
\text{Invariance}.
\]

---

## 28. End-State

SRM-0009 establishes invariant sets as first-class mathematical structures of the SMOF transition system.

It provides the foundation for subsequent specifications concerning attractors, stability, invariant manifolds, transition graphs, safety regions, and higher-order dynamical structures.

---

**End of SRM-0009**
