# SRM-0008 — Transition Periodicity and Recurrence Mathematics

**Document ID:** SRM-0008
**Title:** Transition Periodicity and Recurrence Mathematics
**System:** SMOF Kernel
**Domain:** State Transition Mathematics
**Status:** Canonical Draft
**Predecessors:** SRM-0002, SRM-0003, SRM-0004, SRM-0005, SRM-0006, SRM-0007

---

## 1. Purpose

SRM-0008 defines the mathematics of periodicity, recurrence, return, cycles, and eventual periodicity for state transitions in the SMOF Kernel.

The specification extends the reachability and orbit mathematics of SRM-0007 by formalizing when a state, orbit, subset, or transition sequence returns to a previously occupied state or structural configuration.

---

## 2. Scope

This specification establishes:

1. periodic states;
2. minimal periods;
3. fixed points;
4. periodic orbits;
5. recurrent states;
6. return times;
7. eventual periodicity;
8. transient and recurrent components;
9. cycles;
10. recurrence classes;
11. periodic subsets;
12. transition recurrence;
13. finite-state recurrence;
14. infinite-state recurrence;
15. recurrence under composition;
16. recurrence under conjugacy;
17. invariance of periodicity;
18. relationships between reachability and recurrence.

---

## 3. Mathematical Setting

Let

\[
S
\]

be a state space and let

\[
P:S\to S
\]

be a state transition operator.

For

\[
n\in\mathbb{N}_0
\]

define

\[
P^0=\operatorname{id}_S
\]

and

\[
P^{n+1}=P\circ P^n.
\]

The forward orbit of a state \(x\in S\) is

\[
\mathcal{O}_P^+(x)
=
\{P^n(x):n\in\mathbb{N}_0\}.
\]

The full orbit, when \(P\) is invertible, is

\[
\mathcal{O}_P(x)
=
\{P^n(x):n\in\mathbb{Z}\}.
\]

---

## 4. Return Time

A positive integer

\[
n\in\mathbb{N}
\]

is a return time of \(x\) if

\[
P^n(x)=x.
\]

Define the return-time set

\[
\operatorname{Ret}_P(x)
=
\{n\in\mathbb{N}:P^n(x)=x\}.
\]

If

\[
\operatorname{Ret}_P(x)\neq\varnothing,
\]

then \(x\) is called recurrent in the periodic sense.

---

## 5. Periodic State

A state

\[
x\in S
\]

is periodic under \(P\) if there exists

\[
k\in\mathbb{N}
\]

such that

\[
P^k(x)=x.
\]

The set of periodic states is

\[
\operatorname{Per}(P)
=
\{x\in S:\exists k\geq1,\ P^k(x)=x\}.
\]

---

## 6. Minimal Period

If \(x\) is periodic, its minimal period is

\[
\operatorname{per}_P(x)
=
\min\{k\in\mathbb{N}:P^k(x)=x\}.
\]

The minimal period is uniquely defined.

If

\[
\operatorname{per}_P(x)=1,
\]

then

\[
P(x)=x.
\]

Thus every fixed point is periodic.

---

## 7. Fixed Points

The fixed-point set is

\[
\operatorname{Fix}(P)
=
\{x\in S:P(x)=x\}.
\]

Every fixed point has minimal period one:

\[
x\in\operatorname{Fix}(P)
\implies
\operatorname{per}_P(x)=1.
\]

Therefore

\[
\operatorname{Fix}(P)\subseteq\operatorname{Per}(P).
\]

---

## 8. Periodic Orbit

If \(x\) has minimal period \(k\), then its periodic orbit is

\[
\mathcal{O}_P(x)
=
\{x,P(x),P^2(x),\ldots,P^{k-1}(x)\}.
\]

The states in the orbit satisfy

\[
P^k(x)=x.
\]

Moreover,

\[
P^{k+r}(x)=P^r(x)
\]

for every

\[
r\in\mathbb{N}_0.
\]

Hence the trajectory repeats with period \(k\).

---

## 9. Periodicity of Every State in a Cycle

Suppose

\[
y=P^j(x)
\]

for some

\[
0\leq j<k
\]

and \(x\) has period \(k\).

Then

\[
P^k(y)
=
P^k(P^j(x))
=
P^j(P^k(x))
=
P^j(x)
=
y.
\]

Thus every state in a periodic orbit is periodic.

Furthermore,

\[
\operatorname{per}_P(y)=k.
\]

Therefore all states belonging to the same cycle have the same minimal period.

---

## 10. Divisibility of Return Times

Let \(x\) have minimal period \(k\).

If

\[
P^n(x)=x,
\]

then

\[
k\mid n.
\]

Thus

\[
\operatorname{Ret}_P(x)
=
\{mk:m\in\mathbb{N}\}.
\]

Consequently, every return time is an integer multiple of the minimal period.

---

## 11. Eventual Periodicity

A state \(x\) is eventually periodic if there exist

\[
m\in\mathbb{N}_0
\]

and

\[
k\in\mathbb{N}
\]

such that

\[
P^{m+k}(x)=P^m(x).
\]

The integer \(m\) is a preperiod and \(k\) is a period of the eventual cycle.

The trajectory therefore has the form

\[
x,P(x),\ldots,P^{m-1}(x)
\]

followed by

\[
P^m(x),P^{m+1}(x),\ldots
\]

where the latter sequence is periodic.

---

## 12. Transient States

A state is transient with respect to \(P\) if its forward orbit eventually enters a periodic orbit but the state itself is not periodic.

For an eventually periodic state \(x\), there exist \(m\) and \(k\) such that

\[
P^{m+k}(x)=P^m(x)
\]

while

\[
P^r(x)\neq x
\]

for every positive \(r\).

The transient segment is

\[
x,P(x),\ldots,P^{m-1}(x).
\]

---

## 13. Recurrence

A state \(x\) is recurrent under \(P\) if it returns to itself after a positive number of transitions:

\[
\exists n\geq1
\quad
P^n(x)=x.
\]

Thus

\[
x\in\operatorname{Per}(P)
\]

whenever recurrence is defined in the strict periodic sense.

For the present SRM specification, periodic recurrence means exact state return.

---

## 14. Recurrence Class

Define the recurrence class of \(x\) by

\[
[x]_{\operatorname{rec}}
=
\{y\in S:y\leadsto_P x\text{ and }x\leadsto_P y\}.
\]

Thus two states belong to the same recurrence class when each is reachable from the other.

The relation is an equivalence relation on the mutually reachable recurrent region.

---

## 15. Cycles

A cycle of length \(k\) is a sequence

\[
x_0,x_1,\ldots,x_{k-1}
\]

such that

\[
P(x_i)=x_{i+1}
\]

for

\[
0\leq i<k-1
\]

and

\[
P(x_{k-1})=x_0.
\]

Equivalently,

\[
P^k(x_0)=x_0.
\]

If \(k\) is minimal, the cycle has minimal length \(k\).

---

## 16. Cycle Set

For a periodic state \(x\), define

\[
\operatorname{Cycle}_P(x)
=
\{P^n(x):0\leq n<\operatorname{per}_P(x)\}.
\]

Then

\[
\operatorname{Cycle}_P(x)
=
\mathcal{O}_P^+(x).
\]

The orbit contains exactly the states belonging to the cycle.

---

## 17. Periodic Set

A subset

\[
A\subseteq S
\]

is periodic under \(P\) if there exists

\[
k\in\mathbb{N}
\]

such that

\[
P^k(A)=A.
\]

If

\[
P(A)=A,
\]

then \(A\) is invariant under one-step transition.

---

## 18. Forward-Invariant Set

A subset

\[
A\subseteq S
\]

is forward invariant if

\[
P(A)\subseteq A.
\]

Equivalently,

\[
x\in A
\implies
P^n(x)\in A
\]

for every

\[
n\in\mathbb{N}_0.
\]

Thus

\[
\operatorname{Reach}_P(A)\subseteq A.
\]

---

## 19. Recurrent Set

Define the periodic recurrent set

\[
\operatorname{Rec}(P)
=
\operatorname{Per}(P).
\]

Hence

\[
\operatorname{Rec}(P)
=
\{x\in S:\exists n\geq1,\ P^n(x)=x\}.
\]

The terminology distinguishes recurrence as a dynamical property from arbitrary reachability.

---

## 20. Recurrence and Reachability

If

\[
P^n(x)=x
\]

for some positive \(n\), then

\[
x\leadsto_P x.
\]

Therefore every periodic state is reachable from itself.

Conversely, self-reachability with a positive transition length implies periodicity:

\[
x\leadsto_P x
\text{ via }n\geq1
\implies
P^n(x)=x.
\]

---

## 21. Reachability Closure

For a state \(x\),

\[
\operatorname{Reach}_P(x)
=
\{P^n(x):n\in\mathbb{N}_0\}.
\]

If \(x\) is periodic with period \(k\), then

\[
|\operatorname{Reach}_P(x)|=k
\]

provided the states in the cycle are distinct.

Thus the finite reachable set is exactly the periodic orbit.

---

## 22. Eventual Reachability into a Cycle

If

\[
P^{m+k}(x)=P^m(x),
\]

then

\[
P^m(x)\in\operatorname{Per}(P).
\]

Therefore

\[
\operatorname{Reach}_P(x)
\]

contains a transient segment followed by a recurrent cycle.

---

## 23. Finite-State Principle

Suppose \(S\) is finite and

\[
P:S\to S.
\]

For every

\[
x\in S,
\]

there exist integers

\[
0\leq m<n
\]

such that

\[
P^m(x)=P^n(x).
\]

Therefore every finite-state deterministic transition is eventually periodic.

---

## 24. Pigeonhole Proof

Consider

\[
x,P(x),P^2(x),\ldots,P^{|S|}(x).
\]

There are

\[
|S|+1
\]

states in the sequence but only

\[
|S|
\]

possible elements of \(S\).

Hence two positions coincide:

\[
P^m(x)=P^n(x)
\]

for some

\[
0\leq m<n\leq |S|.
\]

Applying the transition operator repeatedly gives

\[
P^{m+r}(x)=P^{n+r}(x)
\]

for all

\[
r\in\mathbb{N}_0.
\]

Thus the trajectory becomes periodic.

---

## 25. Functional Graph Structure

For a finite deterministic state space, construct a directed graph with:

- one vertex for every state;
- one directed edge \(x\to P(x)\) for every state.

Every connected component contains at least one directed cycle.

Each state outside the cycle lies on a finite transient path leading into a cycle.

Therefore the component has the structure

\[
\text{transient trees}
\longrightarrow
\text{cycle}.
\]

---

## 26. Cycle Entry Time

For an eventually periodic state \(x\), define its cycle-entry time by

\[
\tau_P(x)
=
\min\{m\geq0:P^m(x)\in\operatorname{Per}(P)\}.
\]

If \(x\) is already periodic, then

\[
\tau_P(x)=0.
\]

The pair

\[
(\tau_P(x),\operatorname{per}_P(P^{\tau_P(x)}(x)))
\]

characterizes the transient length and eventual period.

---

## 27. Eventual Period

Define the eventual period by

\[
\operatorname{eper}_P(x)
=
\operatorname{per}_P(P^{\tau_P(x)}(x)).
\]

For a periodic state,

\[
\operatorname{eper}_P(x)
=
\operatorname{per}_P(x).
\]

---

## 28. Recurrence Under Iterated Transition

If

\[
P^k(x)=x,
\]

then for every

\[
m\in\mathbb{N},
\]

\[
P^{mk}(x)=x.
\]

Hence the return times contain

\[
k,2k,3k,\ldots.
\]

---

## 29. Transition Powers and Periodicity

For every positive integer \(r\),

\[
(P^r)^n=P^{rn}.
\]

Therefore

\[
(P^r)^n(x)=x
\]

if and only if

\[
P^{rn}(x)=x.
\]

If \(x\) has period \(k\), then its period under \(P^r\) is

\[
\frac{k}{\gcd(k,r)}.
\]

---

## 30. Period Reduction Under Sampling

Sampling a periodic trajectory every \(r\) transitions may reduce its observed period.

If

\[
\operatorname{per}_P(x)=k,
\]

then

\[
\operatorname{per}_{P^r}(x)
=
\frac{k}{\gcd(k,r)}.
\]

In particular,

\[
\operatorname{per}_{P^r}(x)=1
\]

exactly when

\[
k\mid r.
\]

---

## 31. Identity Transition

For the identity transition

\[
I_S=\operatorname{id}_S,
\]

every state satisfies

\[
I_S(x)=x.
\]

Therefore

\[
\operatorname{Per}(I_S)=S
\]

and

\[
\operatorname{per}_{I_S}(x)=1.
\]

---

## 32. Invertible Transitions

Suppose

\[
P:S\to S
\]

is invertible.

Then the full orbit is

\[
\mathcal{O}_P(x)
=
\{P^n(x):n\in\mathbb{Z}\}.
\]

If

\[
P^k(x)=x,
\]

then

\[
P^{-k}(x)=x.
\]

Thus periodicity is compatible with both forward and backward dynamics.

---

## 33. Periodic Orbits of Invertible Transitions

For invertible \(P\), every periodic orbit forms a directed cycle with a unique predecessor and successor for every state.

Hence a periodic orbit is structurally equivalent to the cyclic action of

\[
\mathbb{Z}/k\mathbb{Z}.
\]

---

## 34. Conjugacy

Let

\[
P:S\to S
\]

and

\[
Q:T\to T
\]

be transitions.

Suppose

\[
\phi:S\to T
\]

is a bijection satisfying

\[
Q\circ\phi
=
\phi\circ P.
\]

Then \(P\) and \(Q\) are conjugate.

Equivalently,

\[
Q
=
\phi\circ P\circ\phi^{-1}.
\]

---

## 35. Periodicity Is Conjugacy Invariant

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

Therefore

\[
x\in\operatorname{Per}(P)
\iff
\phi(x)\in\operatorname{Per}(Q).
\]

---

## 36. Minimal Period Is Conjugacy Invariant

If

\[
\operatorname{per}_P(x)=k,
\]

then

\[
\operatorname{per}_Q(\phi(x))=k.
\]

Hence conjugacy preserves:

- periodicity;
- minimal period;
- cycle length;
- fixed points;
- recurrence structure.

---

## 37. Fixed Points Under Conjugacy

If

\[
P(x)=x,
\]

then

\[
Q(\phi(x))
=
\phi(P(x))
=
\phi(x).
\]

Therefore

\[
\phi(\operatorname{Fix}(P))
=
\operatorname{Fix}(Q).
\]

---

## 38. Orbit Correspondence

Under conjugacy,

\[
\phi(P^n(x))
=
Q^n(\phi(x))
\]

for every

\[
n\in\mathbb{Z}
\]

when both transitions are invertible.

Therefore

\[
\phi(\mathcal{O}_P(x))
=
\mathcal{O}_Q(\phi(x)).
\]

---

## 39. Periodic Cycle Correspondence

If \(C\) is a periodic cycle of \(P\), then

\[
\phi(C)
\]

is a periodic cycle of \(Q\) with exactly the same cardinality.

Thus conjugacy does not change cycle length.

---

## 40. Composition and Periodicity

Let

\[
P_{0:n}
=
P_{n-1}\circ\cdots\circ P_0.
\]

A state \(x\) is periodic under the composed transition if there exists

\[
k\geq1
\]

such that

\[
(P_{0:n})^k(x)=x.
\]

Therefore recurrence of a composed transition is determined by repeated application of the composite operator.

---

## 41. Identity and Periodicity

For any transition \(P\),

\[
I_S\circ P=P
\]

and

\[
P\circ I_S=P.
\]

Thus insertion of identity transitions does not alter periodicity.

---

## 42. Inverse and Periodicity

If \(P\) is invertible and

\[
P^k(x)=x,
\]

then

\[
(P^{-1})^k(x)=x.
\]

Therefore

\[
\operatorname{per}_{P^{-1}}(x)
=
\operatorname{per}_P(x).
\]

---

## 43. Periodic Invariants

The following quantities are invariant under conjugacy:

\[
\operatorname{per}_P(x),
\]

cycle cardinality,

fixed-point status,

and recurrence status.

These constitute transition-structural invariants.

---

## 44. Recurrence and Equivalence

Let

\[
x\sim_P y
\]

mean that \(x\) and \(y\) are mutually reachable.

If \(x\) is periodic and

\[
x\sim_P y,
\]

then \(y\) is periodic.

Indeed, mutual reachability gives positive integers \(m,n\) such that

\[
P^m(x)=y
\]

and

\[
P^n(y)=x.
\]

Therefore

\[
P^{m+n}(x)=x.
\]

The corresponding cycle structure is contained in the same recurrent class.

---

## 45. Recurrence Class Theorem

For deterministic transitions, every recurrent equivalence class is a strongly connected component.

If the class is finite, the transition restricted to the class decomposes into one or more cycles only when the transition is bijective on that class.

---

## 46. Periodicity and State Transition Mathematics

SRM-0008 extends the SRM hierarchy:

\[
\text{State}
\to
\text{Transition}
\to
\text{Composition}
\to
\text{Identity}
\to
\text{Invertibility}
\to
\text{Equivalence}
\to
\text{Reachability}
\to
\text{Orbit}
\to
\text{Periodicity}
\to
\text{Recurrence}.
\]

This establishes periodicity and recurrence as higher-order structural properties of transition dynamics.

---

## 47. Canonical Definitions

The canonical objects of SRM-0008 are:

\[
\operatorname{Ret}_P(x)
=
\{n\in\mathbb{N}:P^n(x)=x\},
\]

\[
\operatorname{Per}(P)
=
\{x\in S:\exists n\geq1,\ P^n(x)=x\},
\]

\[
\operatorname{per}_P(x)
=
\min\{n\geq1:P^n(x)=x\},
\]

\[
\tau_P(x)
=
\min\{m\geq0:P^m(x)\in\operatorname{Per}(P)\},
\]

and

\[
\operatorname{eper}_P(x)
=
\operatorname{per}_P(P^{\tau_P(x)}(x)).
\]

---

## 48. SRM-0008 Core Theorem

For a deterministic transition

\[
P:S\to S,
\]

every finite-state trajectory is eventually periodic.

If a state is periodic, then its orbit is a finite cycle whose cardinality equals its minimal period.

If two transitions are conjugate, corresponding states have identical periodicity, recurrence, and cycle-length structure.

---

## 49. Relationship to SRM-0007

SRM-0007 established reachability and orbit mathematics:

\[
\operatorname{Reach}_P(x)
=
\{P^n(x):n\in\mathbb{N}_0\}.
\]

SRM-0008 identifies the special orbit structures produced when a trajectory returns to a previously occupied state.

Thus:

\[
\text{Reachability}
\longrightarrow
\text{Orbit}
\longrightarrow
\text{Return}
\longrightarrow
\text{Periodicity}
\longrightarrow
\text{Recurrence}.
\]

---

## 50. Canonical Closure

SRM-0008 establishes the mathematical foundation for transition periodicity and recurrence within the SMOF Kernel.

The specification is compatible with:

- SRM-0002 Runtime Transition;
- SRM-0003 State Transition Mathematics;
- SRM-0004 Transition Composition Mathematics;
- SRM-0005 Transition Identity and Invertibility Mathematics;
- SRM-0006 Transition Equivalence and Conjugacy Mathematics;
- SRM-0007 Transition Reachability and Orbit Mathematics.

It provides the formal transition-dynamical foundation required for subsequent SRM specifications concerning invariant sets, attractors, stability, transition graphs, and higher-order dynamical structure.

---

**End of SRM-0008**
