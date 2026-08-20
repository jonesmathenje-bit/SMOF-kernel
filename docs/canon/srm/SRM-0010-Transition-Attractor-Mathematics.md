# SRM-0010 — Transition Attractor Mathematics

**Document ID:** SRM-0010
**Title:** Transition Attractor Mathematics
**System:** SMOF Kernel
**Domain:** State Transition Mathematics
**Status:** Canonical Draft
**Predecessors:** SRM-0002, SRM-0003, SRM-0004, SRM-0005, SRM-0006, SRM-0007, SRM-0008, SRM-0009

---

## 1. Purpose

SRM-0010 formally defines attractors within the SMOF State Transition Mathematics layer.

An attractor is a dynamically distinguished state-space structure toward which admissible trajectories converge, return, or become asymptotically confined under a transition operator.

This specification establishes the mathematical vocabulary required to distinguish invariant sets, attracting sets, attractors, basins of attraction, fixed-point attractors, periodic attractors, orbit attractors, asymptotic attractors, minimal attractors, and global attractors.

---

## 2. Scope

Let

\[
P:S\to S
\]

be a SMOF transition operator on state space \(S\).

SRM-0010 defines the conditions under which a subset

\[
A\subseteq S
\]

qualifies as an attracting dynamical structure.

The specification covers deterministic discrete-time transition systems and provides the foundation for subsequent stability and dynamical-structure specifications.

---

## 3. Foundational Transition System

A SMOF transition system is

\[
\mathfrak{T}=(S,P)
\]

where \(S\) is the state space and

\[
P:S\to S
\]

is the transition operator.

The \(n\)-step transition is

\[
P^n:S\to S,
\qquad n\in\mathbb{N}_0.
\]

For \(x\in S\), the forward orbit is

\[
\mathcal{O}_P^+(x)
=
\{P^n(x):n\in\mathbb{N}_0\}.
\]

---

## 4. Invariant Sets

A subset \(A\subseteq S\) is invariant when

\[
P(A)=A.
\]

A subset is forward invariant when

\[
P(A)\subseteq A.
\]

Forward invariance guarantees that a trajectory beginning in \(A\) remains in \(A\).

---

## 5. Distance to a Set

For a metric state space \((S,d)\), define

\[
d(x,A)
=
\inf_{a\in A}d(x,a).
\]

This quantity measures the distance from state \(x\) to the set \(A\).

---

## 6. Attracting Set

A subset \(A\subseteq S\) is attracting for a state \(x\) when

\[
\lim_{n\to\infty}
d(P^n(x),A)=0.
\]

Thus the trajectory becomes arbitrarily close to \(A\) as the transition count tends to infinity.

---

## 7. Attractor

An attractor is an invariant or forward-invariant set possessing a nonempty basin of attraction.

Formally,

\[
P(A)\subseteq A
\]

and there exists a nonempty set \(B_P(A)\subseteq S\) such that

\[
\forall x\in B_P(A),
\qquad
\lim_{n\to\infty}
d(P^n(x),A)=0.
\]

When full invariance is required,

\[
P(A)=A.
\]

---

## 8. Basin of Attraction

The basin of attraction of \(A\) is

\[
B_P(A)
=
\left\{
x\in S:
\lim_{n\to\infty}d(P^n(x),A)=0
\right\}.
\]

Therefore,

\[
x\in B_P(A)
\]

means that \(x\) is asymptotically attracted to \(A\).

---

## 9. Fixed-Point Attractor

A state \(x^\ast\in S\) is a fixed point when

\[
P(x^\ast)=x^\ast.
\]

The singleton

\[
A=\{x^\ast\}
\]

is a fixed-point attractor when

\[
\lim_{n\to\infty}
d(P^n(x),x^\ast)=0
\]

for all \(x\) in a nonempty basin.

---

## 10. Periodic Attractor

A state \(x\in S\) has period \(k\geq1\) when

\[
P^k(x)=x
\]

and

\[
P^j(x)\neq x
\]

for

\[
1\leq j<k.
\]

Its periodic orbit is

\[
A_x
=
\{x,P(x),\ldots,P^{k-1}(x)\}.
\]

When this orbit attracts a nonempty basin, \(A_x\) is a periodic attractor.

---

## 11. Orbit Attractor

An orbit-generated set

\[
A=\mathcal{O}_P^+(x)
\]

is an attractor when it satisfies the required invariance and attraction conditions.

For periodic dynamics,

\[
\mathcal{O}_P^+(x)
=
\mathcal{O}_P(x).
\]

---

## 12. Asymptotic Attraction

A state \(x\) is asymptotically attracted to \(A\) when

\[
\lim_{n\to\infty}d(P^n(x),A)=0.
\]

The notation

\[
P^n(x)\longrightarrow A
\]

denotes convergence to the set \(A\), not necessarily to a single point.

---

## 13. Attraction and Reachability

Reachability asks whether

\[
\exists n\geq0:
P^n(x)=y.
\]

Attraction asks whether

\[
\lim_{n\to\infty}d(P^n(x),A)=0.
\]

Therefore,

\[
\boxed{
\text{reachability}\neq\text{attraction}
}
\]

in general.

A trajectory may approach an attractor without ever entering it exactly.

---

## 14. Attraction and Recurrence

Recurrence concerns repeated return behavior.

Attraction concerns asymptotic approach.

For a periodic attractor \(A\),

\[
P^k(A)=A
\]

while states in its basin may satisfy

\[
\lim_{n\to\infty}d(P^n(x),A)=0.
\]

Thus recurrence characterizes persistent return structure while attraction characterizes convergence toward that structure.

---

## 15. Attraction and Invariance

An attractor must satisfy the relevant invariance condition:

\[
P(A)\subseteq A.
\]

For full invariance,

\[
P(A)=A.
\]

Hence

\[
\operatorname{Attractor}(P)
\subseteq
\operatorname{InvariantSet}(P).
\]

The converse does not generally hold.

An invariant set need not attract states outside itself.

---

## 16. Minimal Attractor

An attractor \(A\) is minimal when no proper subset

\[
A'\subsetneq A
\]

is itself an attractor satisfying the same defining conditions.

Thus minimality eliminates dynamically redundant enlargement.

---

## 17. Global Attractor

An attractor \(A\) is global when

\[
B_P(A)=S.
\]

Equivalently,

\[
\forall x\in S,
\qquad
\lim_{n\to\infty}d(P^n(x),A)=0.
\]

A global attractor therefore attracts every state.

---

## 18. Local Attractor

An attractor is local when

\[
\varnothing\neq B_P(A)\subsetneq S.
\]

Multiple local attractors may therefore coexist.

---

## 19. Basin Invariance

If

\[
x\in B_P(A),
\]

then

\[
P(x)\in B_P(A).
\]

Consequently,

\[
P(B_P(A))
\subseteq
B_P(A).
\]

The basin of an attractor is therefore forward invariant under the transition operator.

---

## 20. Trapping Region

A set \(U\subseteq S\) is a trapping region when

\[
P(U)\subseteq U.
\]

Repeated transition produces

\[
U\supseteq P(U)\supseteq P^2(U)\supseteq\cdots.
\]

When the limiting structure exists,

\[
A
=
\bigcap_{n\geq0}P^n(U)
\]

provides a candidate attractor.

---

## 21. Attracting Neighborhood

A neighborhood \(U\) of \(A\) is attracting when trajectories entering \(U\) remain in the relevant dynamical region and approach \(A\).

A typical condition is

\[
P(U)\subseteq U
\]

together with

\[
\lim_{n\to\infty}d(P^n(x),A)=0
\]

for states \(x\in U\).

---

## 22. Finite-Time Capture

A state \(x\) is finitely captured by \(A\) when

\[
\exists N\geq0:
P^N(x)\in A.
\]

Under invariant-attractor conditions,

\[
\text{finite capture}
\Rightarrow
\text{asymptotic attraction}.
\]

The converse need not hold.

---

## 23. Attraction Without Exact Entry

A trajectory may satisfy

\[
\lim_{n\to\infty}d(P^n(x),A)=0
\]

while

\[
P^n(x)\notin A
\]

for every finite \(n\).

Thus asymptotic attraction does not require exact reachability.

---

## 24. Finite-State Attractors

For finite deterministic state spaces, every sufficiently long trajectory eventually repeats.

There exist integers

\[
m\geq0,\qquad k\geq1
\]

such that

\[
P^{m+k}(x)=P^m(x).
\]

The resulting cycle is a periodic invariant structure and provides a natural finite-state attractor candidate.

---

## 25. Functional-Graph Interpretation

A finite deterministic transition system forms a directed functional graph.

Every connected component contains at least one directed cycle.

Therefore,

\[
\boxed{
\text{finite deterministic dynamics}
\Rightarrow
\text{eventual periodicity}
}
\]

and upstream states may be attracted to the recurrent cycle.

---

## 26. Algorithmic Attractor Extraction

Given \(x_0\in S\), define

\[
x_{n+1}=P(x_n).
\]

Record each visited state.

If

\[
x_i=x_j
\]

for some

\[
0\leq i<j,
\]

then the cycle length is

\[
k=j-i.
\]

The candidate attractor is

\[
A=
\{x_i,x_{i+1},\ldots,x_{j-1}\}.
\]

---

## 27. Basin Computation

For a finite attractor \(A\), its predecessor basin may be computed recursively.

Define

\[
B_0=A
\]

and

\[
B_{n+1}
=
B_n\cup P^{-1}(B_n).
\]

Then

\[
B_P(A)
=
\bigcup_{n\geq0}B_n
\]

for the finite-state capture interpretation.

---

## 28. Attractor Certification

A candidate \(A\) is certified when the required predicates hold:

\[
P(A)\subseteq A,
\]

\[
B_P(A)\neq\varnothing,
\]

and

\[
\forall x\in B_P(A),
\qquad
\lim_{n\to\infty}d(P^n(x),A)=0.
\]

For full invariance,

\[
P(A)=A.
\]

---

## 29. Attractor Equivalence

Let

\[
P:S\to S
\]

and

\[
Q:T\to T
\]

be conjugate through a bijection

\[
\phi:S\to T
\]

satisfying

\[
Q\circ\phi
=
\phi\circ P.
\]

If \(A\) is an attractor of \(P\), then

\[
\phi(A)
\]

is the corresponding attractor of \(Q\), provided the structures defining attraction are preserved.

---

## 30. Basin Transport Under Conjugacy

Under a structure-preserving conjugacy,

\[
\phi(B_P(A))
=
B_Q(\phi(A)).
\]

Thus conjugacy transports both attractor structure and its basin when the relevant topological or metric structure is preserved.

---

## 31. Fixed-Point Preservation

If

\[
P(x^\ast)=x^\ast,
\]

then

\[
Q(\phi(x^\ast))
=
\phi(P(x^\ast))
=
\phi(x^\ast).
\]

Therefore fixed points are preserved under conjugacy.

---

## 32. Periodic Attractor Preservation

If

\[
P^k(x)=x,
\]

then

\[
Q^k(\phi(x))
=
\phi(P^k(x))
=
\phi(x).
\]

Therefore periodic attractors are transported with their period preserved.

---

## 33. Multiple Attractors

Let

\[
A_1,\ldots,A_m
\]

be distinct attractors.

Their basins are

\[
B_i=B_P(A_i).
\]

Under uniqueness of the asymptotic attractor,

\[
B_i\cap B_j=\varnothing
\]

for

\[
i\neq j.
\]

The state space may then decompose into attraction basins together with a residual set.

---

## 34. Basin Decomposition

A dynamical decomposition may be written

\[
S
=
\left(
\bigcup_{i\in I}B_P(A_i)
\right)
\cup R,
\]

where \(R\) contains states not assigned to the specified attractors.

The residual set may contain transient, wandering, unstable, or otherwise unresolved trajectories.

---

## 35. Attractor Boundary

For an attractor basin

\[
B_P(A),
\]

its boundary is

\[
\partial B_P(A).
\]

When multiple attractors coexist, basin boundaries separate regions with different asymptotic outcomes.

---

## 36. Omega-Limit Structure

For a state \(x\), define

\[
\omega_P(x)
=
\bigcap_{N\geq0}
\overline{
\{P^n(x):n\geq N\}
}.
\]

Under appropriate continuity and compactness assumptions, the omega-limit set captures the asymptotic accumulation structure of the orbit.

---

## 37. Attractor and Omega-Limit Set

For \(x\in B_P(A)\), an appropriate attractor may satisfy

\[
\omega_P(x)\subseteq A.
\]

Under stronger minimality conditions,

\[
A=\omega_P(x)
\]

may hold for selected trajectories.

Thus omega-limit structures provide a formal bridge between recurrence and attraction.

---

## 38. Dynamical Classification

The attractor structure defines a dynamical classification map

\[
\mathfrak{A}:
(S,P)
\longmapsto
\{A_i\}_{i\in I}.
\]

Possible classifications include:

- no detected attractor;
- unique attractor;
- multiple attractors;
- fixed-point attractor;
- periodic attractor;
- global attractor;
- mixed attractor system.

---

## 39. Computational Representation

An attractor may be represented by

\[
\mathcal{A}
=
(A,B,\Pi,I),
\]

where:

- \(A\) is the attractor;
- \(B\) is its basin;
- \(\Pi\) records periodicity or recurrence;
- \(I\) records invariance certification.

This representation separates the attractor itself from its dynamical evidence.

---

## 40. Attractor Certification Predicate

Define

\[
\operatorname{IsAttractor}(P,A)
\]

to mean that all required attractor predicates hold.

At minimum,

\[
\operatorname{IsAttractor}(P,A)
\Rightarrow
P(A)\subseteq A.
\]

For metric attraction,

\[
\operatorname{IsAttractor}(P,A)
\Rightarrow
\exists x\in S:
\lim_{n\to\infty}d(P^n(x),A)=0.
\]

---

## 41. Relationship to Previous SRM Specifications

SRM-0010 depends structurally on:

- SRM-0002 Runtime Transition;
- SRM-0003 State Transition Mathematics;
- SRM-0004 Transition Composition Mathematics;
- SRM-0005 Transition Identity and Invertibility Mathematics;
- SRM-0006 Transition Equivalence and Conjugacy Mathematics;
- SRM-0007 Transition Reachability and Orbit Mathematics;
- SRM-0008 Transition Periodicity and Recurrence Mathematics;
- SRM-0009 Transition Invariant Sets Mathematics.

The dependency chain is

\[
\mathrm{Transition}
\to
\mathrm{Orbit}
\to
\mathrm{Recurrence}
\to
\mathrm{Invariance}
\to
\mathrm{Attraction}.
\]

---

## 42. Canonical Dependency Relation

The canonical transition-dynamics sequence is

\[
\boxed{
\mathrm{SRM\!-\!0002}
\to
\mathrm{SRM\!-\!0003}
\to
\mathrm{SRM\!-\!0004}
\to
\mathrm{SRM\!-\!0005}
\to
\mathrm{SRM\!-\!0006}
\to
\mathrm{SRM\!-\!0007}
\to
\mathrm{SRM\!-\!0008}
\to
\mathrm{SRM\!-\!0009}
\to
\mathrm{SRM\!-\!0010}
}
\]

SRM-0010 extends the preceding transition mathematics without replacing any predecessor specification.

---

## 43. End-State

SRM-0010 establishes transition attractors as first-class mathematical structures within the SMOF Kernel.

It formalizes invariant attracting structures, basins of attraction, fixed-point attractors, periodic attractors, global and local attraction, trapping regions, asymptotic behavior, attractor detection, certification, and conjugacy preservation.

This specification provides the mathematical foundation for subsequent SRM specifications concerning stability, Lyapunov structures, transition graphs, attractor networks, invariant manifolds, and higher-order dynamical systems.

---

**End of SRM-0010**
