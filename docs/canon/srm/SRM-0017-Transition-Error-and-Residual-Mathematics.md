# SRM-0017 — Transition Error and Residual Mathematics

**Status:** Canonical
**Domain:** SMOF Runtime Mathematics
**Series:** State-Transition Mathematics
**Predecessors:** SRM-0015, SRM-0016
**Artifact:** SRM-0017
**Version:** 1.0
**Classification:** Foundational Mathematical Specification

---

## 1. Purpose

SRM-0017 defines the mathematical theory of error and residual quantities associated with state transitions in the SMOF Runtime Mathematics framework.

The purpose of this specification is to establish a canonical mathematical language for measuring:

* deviation of a state from a reference state;
* deviation from a target set;
* failure of a state to satisfy a transition equation;
* fixed-point residual;
* transition residual;
* local and global error;
* propagated error;
* perturbation-induced error;
* a posteriori error estimates;
* stopping criteria;
* error certification.

SRM-0017 provides the error quantities whose evolution is analyzed by SRM-0016.

---

## 2. Scope

Let a transition system be represented by

[
\mathcal T=(\mathcal X,T),
]

where

* (\mathcal X) is the state space;
* (T:\mathcal X\rightarrow\mathcal X) is a transition operator.

A trajectory is

[
x_{k+1}=T(x_k).
]

The theory also permits non-autonomous transitions

[
x_{k+1}=T_k(x_k).
]

SRM-0017 concerns the mathematical quantities used to measure transition correctness and state deviation.

---

## 3. Mathematical Setting

Let

[
(\mathcal X,d)
]

be a metric state space.

For normed spaces, let

[
|\cdot|
]

denote the relevant norm.

For an operator

[
T:\mathcal X\rightarrow\mathcal X,
]

a reference state is denoted by

[
x^\ast.
]

A target set is denoted by

[
\mathcal A\subseteq\mathcal X.
]

---

## 4. State Error

For a reference state (x^\ast), define the state error by

[
e_k=x_k-x^\ast
]

whenever subtraction is defined.

In a general metric space, the corresponding scalar error is

[
E_k=d(x_k,x^\ast).
]

The vector error describes direction and magnitude where linear structure exists.

The metric error provides the coordinate-independent magnitude.

---

## 5. Absolute Error

The absolute state error is

[
E_k=d(x_k,x^\ast).
]

In a normed vector space,

[
E_k=|x_k-x^\ast|.
]

The absolute error satisfies

[
E_k\geq0.
]

Moreover,

[
E_k=0
]

if and only if

[
x_k=x^\ast.
]

---

## 6. Relative Error

If

[
x^\ast\neq0,
]

define the relative error by

[
E_k^{\mathrm{rel}}


\frac{|x_k-x^\ast|}
{|x^\ast|}.
]

The relative error is dimensionless.

It is useful when comparison against the scale of the reference state is more meaningful than absolute deviation.

---

## 7. Componentwise Error

For

[
x_k=(x_{k,1},\ldots,x_{k,n})
]

and

[
x^\ast=(x_1^\ast,\ldots,x_n^\ast),
]

define

[
e_{k,i}=x_{k,i}-x_i^\ast.
]

The componentwise absolute error is

[
|e_{k,i}|.
]

The maximum component error is

[
E_k^{\infty}


\max_i |e_{k,i}|.
]

---

## 8. Error with Respect to a Target Set

For a nonempty target set

[
\mathcal A\subseteq\mathcal X,
]

define

[
E_k^{\mathcal A}


d(x_k,\mathcal A).
]

Equivalently,

[
E_k^{\mathcal A}


\inf_{a\in\mathcal A}d(x_k,a).
]

The state belongs to the target set exactly when

[
E_k^{\mathcal A}=0.
]

---

## 9. Transition Error

Suppose the intended transition is

[
x_{k+1}=T(x_k).
]

For an observed transition (\widehat x_{k+1}), define the transition error by

[
\varepsilon_{k+1}


d\left(\widehat x_{k+1},T(x_k)\right).
]

In a normed space,

[
\varepsilon_{k+1}


\left|
\widehat x_{k+1}-T(x_k)
\right|.
]

This quantity measures deviation from the transition law itself.

---

## 10. Transition Residual

For a candidate pair ((x_k,x_{k+1})), define the transition residual

[
R_{k+1}


d\left(x_{k+1},T(x_k)\right).
]

In a normed vector space,

[
R_{k+1}


|x_{k+1}-T(x_k)|.
]

An exact transition satisfies

[
R_{k+1}=0.
]

---

## 11. Fixed-Point Residual

For a fixed-point problem

[
T(x^\ast)=x^\ast,
]

define the fixed-point residual

[
R(x)=d(T(x),x).
]

In a normed space,

[
R(x)=|T(x)-x|.
]

Thus,

[
R(x^\ast)=0.
]

A zero residual is therefore a necessary condition for a fixed point.

---

## 12. Residual Versus Error

Error measures distance from a reference solution:

[
E(x)=d(x,x^\ast).
]

Residual measures violation of the defining transition relation:

[
R(x)=d(T(x),x).
]

In general,

[
E(x)\neq R(x).
]

A residual can be small while the state is still far from the desired reference state unless additional mathematical conditions connect residual and error.

---

## 13. Residual-Based Error Bound

Suppose there exists a constant

[
C>0
]

such that

[
E(x)\leq C R(x)
]

for all states in a domain (\mathcal U).

Then the residual provides an a posteriori error bound.

If

[
R(x)\leq\varepsilon,
]

then

[
E(x)\leq C\varepsilon.
]

This establishes a certified connection between residual and state error.

---

## 14. Local Error Bound

A local residual-error relation has the form

[
d(x,x^\ast)
\leq
C_{\mathrm{loc}}R(x)
]

for

[
x\in\mathcal U_{\mathrm{loc}}.
]

The constant (C_{\mathrm{loc}}) may depend on the local geometry or regularity of the transition.

---

## 15. Global Error Bound

A global residual-error relation has the form

[
d(x,x^\ast)
\leq
C_{\mathrm{glob}}R(x)
]

for every

[
x\in\mathcal X.
]

A global estimate is stronger than a local estimate because it does not require prior proximity to the reference state.

---

## 16. Error Propagation

Let

[
x_{k+1}=T(x_k)
]

and suppose (T) is Lipschitz with constant (L):

[
d(T(x),T(y))
\leq
L,d(x,y).
]

Then

[
E_{k+1}
\leq
L E_k.
]

If

[
L<1,
]

the transition contracts error.

---

## 17. Perturbed Error Propagation

Suppose

[
\widehat x_{k+1}


T(\widehat x_k)+\eta_k,
]

where (\eta_k) is transition perturbation.

Then

[
E_{k+1}
\leq
L E_k+|\eta_k|.
]

This is the fundamental error-propagation inequality for perturbed transitions.

---

## 18. Iterated Error Bound

If

[
E_{k+1}\leq qE_k+\eta_k
]

with

[
0\leq q<1,
]

then

[
E_k
\leq
q^kE_0
+
\sum_{j=0}^{k-1}q^{k-1-j}\eta_j.
]

This separates initial-condition error from accumulated transition error.

---

## 19. Uniform Perturbation Bound

If

[
\eta_k\leq\eta
]

for every (k), then

[
E_k
\leq
q^kE_0
+
\eta
\sum_{j=0}^{k-1}q^{k-1-j}.
]

Therefore,

[
E_k
\leq
q^kE_0
+
\eta\frac{1-q^k}{1-q}.
]

Consequently,

[
\limsup_{k\to\infty}E_k
\leq
\frac{\eta}{1-q}.
]

---

## 20. Residual Sequence

For a trajectory

[
{x_k}_{k\geq0},
]

define the residual sequence

[
R_k=d(x_{k+1},T(x_k)).
]

For an exact trajectory,

[
R_k=0
]

for every (k).

---

## 21. Residual Decay

Residual convergence occurs when

[
R_k\to0.
]

A geometric residual bound is

[
R_k\leq Cq^k
]

with

[
0\leq q<1.
]

A polynomial residual bound has the form

[
R_k\leq\frac{C}{k^p}
]

for

[
p>0.
]

---

## 22. Residual Rate

When (R_k>0), define the residual ratio

[
r_k^{R}


\frac{R_{k+1}}{R_k}.
]

If

[
\limsup_{k\to\infty}r_k^R<1,
]

the residual decays at a linear asymptotic rate.

---

## 23. Residual Order

The residual sequence has order (p) if

[
\lim_{k\to\infty}
\frac{R_{k+1}}{R_k^p}


C
]

for some finite positive constant (C).

This extends the convergence-rate concepts of SRM-0016 from state error to residual error.

---

## 24. Error and Residual Equivalence

A transition admits local error-residual equivalence if there exist constants

[
0<c\leq C<\infty
]

such that

[
cE(x)
\leq
R(x)
\leq
CE(x)
]

throughout a neighborhood of (x^\ast).

Then

[
E(x)\asymp R(x).
]

Thus error and residual have equivalent local asymptotic scales.

---

## 25. Residual Reliability

A residual estimator is reliable if

[
E(x)\leq C_{\mathrm{rel}}R(x).
]

The constant

[
C_{\mathrm{rel}}
]

is the reliability constant.

A smaller reliability constant provides a tighter error estimate.

---

## 26. Residual Efficiency

A residual estimator is efficient if

[
R(x)\leq C_{\mathrm{eff}}E(x).
]

The constant

[
C_{\mathrm{eff}}
]

is the efficiency constant.

Reliability and efficiency together give

[
\frac{1}{C_{\mathrm{rel}}}E(x)
\leq
R(x)
\leq
C_{\mathrm{eff}}E(x).
]

---

## 27. A Posteriori Error Estimate

An estimate computed from the current state or residual is called an a posteriori estimate.

Let

[
\widehat E(x)=C_{\mathrm{est}}R(x).
]

If

[
E(x)\leq\widehat E(x),
]

then (\widehat E) is a certified upper error estimate.

---

## 28. A Priori Error Estimate

An a priori estimate predicts error before the transition is executed.

A typical form is

[
E_k\leq Cq^kE_0.
]

A priori estimates depend on known mathematical properties of the transition.

---

## 29. Stopping Criterion

Given tolerance

[
\varepsilon>0,
]

a residual stopping rule is

[
R_k\leq\varepsilon.
]

A certified stopping rule is stronger:

[
C_{\mathrm{rel}}R_k\leq\varepsilon.
]

Then

[
E_k\leq\varepsilon.
]

---

## 30. Relative Stopping Criterion

For nonzero reference state (x^\ast), define

[
R_k^{\mathrm{rel}}


\frac{R_k}{|x^\ast|}.
]

A relative stopping condition is

[
R_k^{\mathrm{rel}}\leq\varepsilon_{\mathrm{rel}}.
]

---

## 31. Combined Stopping Criterion

A robust runtime may require

[
E_k\leq\varepsilon_E
]

and

[
R_k\leq\varepsilon_R.
]

The combined certification condition is

[
\mathsf{Cert}_{\mathrm{err}}(k)


\mathbf 1
\left{
E_k\leq\varepsilon_E
\land
R_k\leq\varepsilon_R
\right}.
]

---

## 32. Error Under Composition

Let

[
T=T_m\circ\cdots\circ T_1.
]

Suppose each operator satisfies

[
d(T_i(x),T_i(y))
\leq q_i d(x,y).
]

Then

[
d(T(x),T(y))
\leq
\left(\prod_{i=1}^{m}q_i\right)d(x,y).
]

Thus the composite error factor is bounded by

[
q_{\mathrm{comp}}


\prod_{i=1}^{m}q_i.
]

---

## 33. Composition of Residuals

For a sequence

[
x_{i+1}=T_i(x_i)+\eta_i,
]

the terminal error is bounded by

[
E_m
\leq
\left(\prod_{i=0}^{m-1}q_i\right)E_0
+
\sum_{j=0}^{m-1}
\left(
\prod_{i=j+1}^{m-1}q_i
\right)\eta_j.
]

This provides the canonical finite-composition error-propagation bound.

---

## 34. Non-Autonomous Error

For

[
x_{k+1}=T_k(x_k),
]

and reference trajectory

[
x_{k+1}^\ast=T_k(x_k^\ast),
]

define

[
E_k=d(x_k,x_k^\ast).
]

If

[
d(T_k(x),T_k(y))
\leq q_kd(x,y),
]

then

[
E_{k+1}\leq q_kE_k.
]

Therefore,

[
E_k
\leq
\left(
\prod_{j=0}^{k-1}q_j
\right)E_0.
]

---

## 35. Error Amplification Factor

Define the finite-horizon amplification factor

[
A_k


\frac{E_k}{E_0},
]

when (E_0>0).

For a contraction sequence,

[
A_k
\leq
\prod_{j=0}^{k-1}q_j.
]

---

## 36. Error Amplification Under Perturbation

For

[
E_{k+1}\leq q_kE_k+\eta_k,
]

define

[
A_{k,j}


\prod_{i=j+1}^{k-1}q_i.
]

Then

[
E_k
\leq
A_{k,0}E_0
+
\sum_{j=0}^{k-1}A_{k,j}\eta_j.
]

This identifies the contribution of each perturbation to the final error.

---

## 37. Local Linearization

Suppose (T) is differentiable at (x^\ast).

For

[
x_k=x^\ast+e_k,
]

we have

[
e_{k+1}


DT(x^\ast)e_k
+
R_2(e_k),
]

where

[
\frac{|R_2(e_k)|}{|e_k|}
\to0
]

as

[
e_k\to0.
]

Thus local error propagation is governed by

[
DT(x^\ast).
]

---

## 38. Linear Residual Relation

For a fixed point,

[
T(x^\ast)=x^\ast.
]

The residual is

[
R(x)=|T(x)-x|.
]

Writing

[
x=x^\ast+e,
]

gives locally

[
T(x)-x


(DT(x^\ast)-I)e
+
o(|e|).
]

Therefore,

[
R(x)


|(DT(x^\ast)-I)e|
+
o(|e|).
]

---

## 39. Invertibility Condition

If

[
DT(x^\ast)-I
]

is invertible, then locally the residual and state error are equivalent under suitable regularity assumptions.

In particular, there exists (C>0) such that

[
|e|
\leq
CR(x).
]

This provides a local residual-based error certificate.

---

## 40. Error Certification Tuple

Define the canonical error certificate by

[
\mathfrak C_{\mathrm{err}}


(
\mathcal X,
x^\ast,
d,
E,
R,
C_{\mathrm{rel}},
\varepsilon
).
]

The certificate is valid when the specified metric, error, residual, reliability bound, and tolerance are valid.

---

## 41. Runtime Error Contract

A transition runtime may expose the contract

[
\mathcal K_{\mathrm{err}}


(
\text{target},
\text{metric},
\text{error},
\text{residual},
\text{bound},
\text{tolerance}
).
]

The runtime must not claim certified convergence unless the associated mathematical conditions are satisfied.

---

## 42. Error Trace

For a runtime trajectory define the error trace

[
\mathcal T_{\mathrm{err}}


\left{
(k,E_k,R_k)
\right}_{k\geq0}.
]

A rate-aware trace may include

[
\mathcal T_{\mathrm{err}}


\left{
(k,E_k,R_k,r_k^E,r_k^R)
\right}_{k\geq0}.
]

---

## 43. Error Audit Record

A canonical error audit record should contain

[
\mathcal A_{\mathrm{err}}


(
\text{transition identifier},
\text{reference},
\text{metric},
\text{error},
\text{residual},
\text{bound},
\text{tolerance},
\text{status}
).
]

The audit record must preserve sufficient information to reconstruct the mathematical basis of the certification decision.

---

## 44. Error Certification Predicate

Define

[
\mathsf{Cert}_{\mathrm{err}}(k)


\mathbf 1
\left{
E_k\leq\varepsilon
\land
C_{\mathrm{rel}}R_k\leq\varepsilon
\right}.
]

A value of

[
1
]

indicates that the specified error conditions are satisfied.

---

## 45. Failure Conditions

An error certificate is invalid when any required condition fails.

Examples include:

* undefined reference state;
* invalid metric;
* invalid residual;
* unreliable error bound;
* tolerance violation;
* numerical overflow;
* non-finite error;
* non-finite residual;
* inconsistent transition data.

---

## 46. Numerical Error

Let

[
\widehat x_k
]

denote a computed state and

[
x_k
]

the mathematically exact state.

Define numerical error by

[
E_k^{\mathrm{num}}


d(\widehat x_k,x_k).
]

This is distinct from the mathematical transition error relative to the target.

---

## 47. Total Error

If

[
x_k^\ast
]

is the desired mathematical state, define total computational error as

[
E_k^{\mathrm{total}}


d(\widehat x_k,x_k^\ast).
]

When intermediate exact states are available,

[
E_k^{\mathrm{total}}
\leq
E_k^{\mathrm{num}}
+
d(x_k,x_k^\ast).
]

Thus total error can contain both numerical and mathematical transition components.

---

## 48. Floating-Point Residual

For a computed transition

[
\widehat x_{k+1}


\widehat T(\widehat x_k),
]

define the computed residual

[
\widehat R_k


d\left(
\widehat x_{k+1},
T(\widehat x_k)
\right).
]

The distinction between

[
R_k
]

and

[
\widehat R_k
]

must be preserved when numerical approximation is present.

---

## 49. Residual Monitoring

Define the runtime residual-monitoring condition

[
\mathsf{Mon}_R(k)


\mathbf 1
\left{
R_k\leq\tau_R
\right}.
]

A monitoring system may additionally require bounded residual growth:

[
R_{k+1}\leq\alpha R_k
]

for a specified factor (\alpha).

---

## 50. Residual Alarm

Define the residual alarm predicate

[
\mathcal A_R(k)


\mathbf 1
\left{
R_k>\tau_R
\right}.
]

A value of (1) indicates that the residual exceeds the permitted tolerance.

---

## 51. Error Alarm

Define

[
\mathcal A_E(k)


\mathbf 1
\left{
E_k>\tau_E
\right}.
]

The runtime may classify a transition as uncertified whenever

[
\mathcal A_E(k)=1
]

or

[
\mathcal A_R(k)=1.
]

---

## 52. Combined Error State

Define the error state

[
\mathbf e_k


(E_k,R_k).
]

A transition is error-certified when

[
\mathbf e_k
\in
[0,\tau_E]\times[0,\tau_R].
]

---

## 53. Error Invariant

An error set

[
\mathcal E_\varepsilon


{x\in\mathcal X:E(x)\leq\varepsilon}
]

is an error neighborhood around the reference state.

If

[
T(\mathcal E_\varepsilon)
\subseteq
\mathcal E_\varepsilon,
]

then the error neighborhood is transition invariant.

---

## 54. Residual Invariant

Define

[
\mathcal R_\tau


{x\in\mathcal X:R(x)\leq\tau}.
]

If

[
T(\mathcal R_\tau)
\subseteq
\mathcal R_\tau,
]

then the residual-certified region is invariant under the transition.

---

## 55. Error Tube

For a reference trajectory

[
{x_k^\ast},
]

define the error tube

[
\mathcal U_\varepsilon


\left{
(k,x):
d(x,x_k^\ast)\leq\varepsilon
\right}.
]

A trajectory remains within the error tube if

[
x_k\in\mathcal U_\varepsilon
]

for every required (k).

---

## 56. Error Budget

Let the total permitted error be

[
\varepsilon_{\mathrm{tot}}.
]

Suppose the error is decomposed as

[
E_k
\leq
E_k^{\mathrm{init}}
+
E_k^{\mathrm{pert}}
+
E_k^{\mathrm{num}}
+
E_k^{\mathrm{model}}.
]

An error budget requires

[
E_k^{\mathrm{init}}
+
E_k^{\mathrm{pert}}
+
E_k^{\mathrm{num}}
+
E_k^{\mathrm{model}}
\leq
\varepsilon_{\mathrm{tot}}.
]

---

## 57. Error Allocation

Let

[
\varepsilon_{\mathrm{tot}}


\sum_{i=1}^{m}\varepsilon_i.
]

Each error source receives an allocation

[
E_i\leq\varepsilon_i.
]

The allocation is valid when

[
\sum_{i=1}^{m}E_i
\leq
\varepsilon_{\mathrm{tot}}.
]

---

## 58. Worst-Case Error

For a family of admissible perturbations

[
\mathcal P,
]

define

[
E_k^{\mathrm{wc}}


\sup_{\eta\in\mathcal P}
E_k(\eta).
]

A robust error guarantee requires

[
E_k^{\mathrm{wc}}\leq\varepsilon.
]

---

## 59. Probabilistic Error

If error is stochastic, define

[
\Pr(E_k>\varepsilon).
]

A probabilistic certificate may require

[
\Pr(E_k\leq\varepsilon)\geq1-\delta.
]

Here

[
\delta
]

is the permitted failure probability.

---

## 60. Error Confidence Certificate

Define

[
\mathsf{Cert}_{\mathrm{prob}}


\mathbf 1
\left{
\Pr(E_k\leq\varepsilon)\geq1-\delta
\right}.
]

This is distinct from deterministic certification.

---

## 61. Error and Convergence

SRM-0016 studies the rate of decay of error quantities.

SRM-0017 defines those quantities.

For example,

[
E_k=d(x_k,x^\ast)
]

may satisfy

[
E_k\leq Cq^k.
]

SRM-0016 determines the convergence class and rate associated with this decay.

---

## 62. Error and Perturbation

SRM-0015 characterizes perturbations.

SRM-0017 converts perturbations into measurable error quantities.

Thus

[
\text{perturbation}
\longrightarrow
\text{error/residual}
\longrightarrow
\text{certification}.
]

---

## 63. Canonical Error Object

Define the abstract SMOF error object by

[
\mathfrak E


(
\mathcal X,
x^\ast,
d,
E,
R,
\mathcal B
),
]

where

[
\mathcal B
]

is the collection of valid error bounds.

---

## 64. Canonical Residual Object

Define

[
\mathfrak R_{\mathrm{res}}


(
\mathcal X,
T,
R,
\varepsilon_R,
\mathcal C_R
),
]

where

* (R) is the residual;
* (\varepsilon_R) is the residual tolerance;
* (\mathcal C_R) is the residual certification rule.

---

## 65. Error-Residual Pair

The fundamental SMOF diagnostic pair is

[
\mathfrak D_k


(E_k,R_k).
]

The pair distinguishes:

* distance from the target;
* violation of the transition relation.

Neither quantity should be silently substituted for the other.

---

## 66. Canonical Error Certificate

A complete error certificate is represented by

[
\mathfrak C_{\mathrm{error}}


(
\mathcal X,
T,
x^\ast,
d,
E,
R,
C_{\mathrm{rel}},
\varepsilon,
\mathsf{Cert}_{\mathrm{err}}
).
]

The certificate is valid only when every required component is mathematically defined and its assumptions hold.

---

## 67. Fundamental Error Theorem

Let (T:\mathcal X\rightarrow\mathcal X) be Lipschitz with constant

[
0\leq q<1
]

and let (x^\ast) be a fixed point:

[
T(x^\ast)=x^\ast.
]

Then

[
E_{k+1}
\leq
qE_k
]

and consequently

[
E_k
\leq
q^kE_0.
]

Thus the transition is globally error-contracting.

---

## 68. Fundamental Perturbed Error Theorem

Suppose

[
\widehat x_{k+1}


T(\widehat x_k)+\eta_k
]

and (T) satisfies

[
d(T(x),T(y))
\leq qd(x,y),
\qquad
q<1.
]

Then

[
E_{k+1}
\leq
qE_k+|\eta_k|.
]

Hence

[
E_k
\leq
q^kE_0
+
\sum_{j=0}^{k-1}
q^{k-1-j}|\eta_j|.
]

---

## 69. Fundamental Residual Certification Theorem

Suppose a residual satisfies

[
E(x)\leq C_{\mathrm{rel}}R(x).
]

If

[
C_{\mathrm{rel}}R(x)\leq\varepsilon,
]

then

[
E(x)\leq\varepsilon.
]

Therefore a residual bound provides a valid a posteriori error certificate.

---

## 70. Error-Residual Equivalence Theorem

Suppose there exist constants

[
0<c\leq C<\infty
]

such that

[
cE(x)\leq R(x)\leq CE(x)
]

in a neighborhood of (x^\ast).

Then

[
E(x)\to0
]

if and only if

[
R(x)\to0.
]

Moreover, the two quantities possess equivalent local asymptotic convergence behavior up to multiplicative constants.

---

## 71. Composition Error Theorem

Let

[
T=T_m\circ\cdots\circ T_1
]

and suppose each (T_i) is Lipschitz with constant (q_i).

Then

[
d(T(x),T(y))
\leq
\left(
\prod_{i=1}^{m}q_i
\right)d(x,y).
]

Therefore the composite transition has contraction factor bounded by

[
q_{\mathrm{comp}}


\prod_{i=1}^{m}q_i.
]

---

## 72. Error Certification Principle

SMOF shall distinguish the following statements:

[
E_k\leq\varepsilon
]

means the state error is within tolerance.

[
R_k\leq\varepsilon_R
]

means the transition residual is within tolerance.

[
C_{\mathrm{rel}}R_k\leq\varepsilon
]

means the residual provides a certified upper bound on state error.

These statements are mathematically different and must not be conflated.

---

## 73. Runtime Certification Rule

A runtime may report

[
\mathsf{CERTIFIED}
]

only if all required certification predicates hold.

Define

[
\mathsf{Cert}_{\mathrm{runtime}}


\bigwedge_{i=1}^{n}\mathsf C_i,
]

where the conditions may include:

[
\mathsf C_1:\text{reference valid},
]

[
\mathsf C_2:\text{metric valid},
]

[
\mathsf C_3:\text{error finite},
]

[
\mathsf C_4:\text{residual finite},
]

[
\mathsf C_5:\text{error bound valid},
]

[
\mathsf C_6:\text{tolerance satisfied}.
]

Failure of any mandatory condition invalidates the certificate.

---

## 74. Error Audit Invariants

A valid error audit must preserve:

1. the identity of the transition;
2. the reference state or target;
3. the metric;
4. the error definition;
5. the residual definition;
6. the tolerance;
7. the error bound;
8. the certification decision.

These quantities form the minimum reproducible mathematical audit state.

---

## 75. Relationship to SRM-0015

SRM-0015 defines transition perturbation mathematics.

SRM-0017 defines the resulting error and residual quantities.

The relationship is

[
\text{Perturbation}
\rightarrow
\text{Error}
\rightarrow
\text{Residual}
\rightarrow
\text{Certification}.
]

---

## 76. Relationship to SRM-0016

SRM-0016 defines convergence-rate mathematics.

SRM-0017 supplies the quantities whose rates may be measured.

In particular,

[
E_k
]

and

[
R_k
]

may each possess:

* linear convergence;
* superlinear convergence;
* sublinear convergence;
* polynomial decay;
* exponential decay;
* finite termination.

Thus SRM-0016 and SRM-0017 form a complementary mathematical pair.

---

## 77. Relationship to Earlier SRM Artifacts

The transition-mathematics chain is:

[
\mathrm{SRM\text{-}0002}
\rightarrow
\mathrm{SRM\text{-}0003}
\rightarrow
\cdots
\rightarrow
\mathrm{SRM\text{-}0015}
\rightarrow
\mathrm{SRM\text{-}0016}
\rightarrow
\mathrm{SRM\text{-}0017}.
]

SRM-0017 therefore extends the existing transition theory rather than replacing earlier artifacts.

---

## 78. Primary Mathematical Invariants

The primary error and residual quantities are

[
E_k=d(x_k,x^\ast),
]

[
E_k^{\mathcal A}=d(x_k,\mathcal A),
]

[
R_k=d(x_{k+1},T(x_k)),
]

and, for fixed-point transitions,

[
R(x)=d(T(x),x).
]

These quantities constitute the primary diagnostic invariants of SRM-0017.

---

## 79. Canonical Diagnostic Tuple

Define

[
\mathfrak D_{\mathrm{SRM17}}


(
E_k,
R_k,
C_{\mathrm{rel}},
\varepsilon,
\mathsf{Cert}_{\mathrm{err}}
).
]

This tuple represents the canonical transition error diagnostic state.

---

## 80. Final Constitutional Statement

SRM-0017 establishes the canonical mathematical principle that a SMOF transition must distinguish **state error**, **target-set error**, and **transition residual**.

Error measures deviation from a mathematical objective.

Residual measures violation of a mathematical transition relation.

A residual becomes a certified error estimator only when an appropriate reliability bound has been established.

Therefore,

[
\boxed{
\text{Residual}
\neq
\text{Error}
}
]

in general, while under suitable mathematical assumptions,

[
\boxed{
E(x)\leq C_{\mathrm{rel}}R(x)
}
]

provides a valid certification mechanism.

The convergence-rate theory of SRM-0016 operates on these quantities, while the perturbation theory of SRM-0015 explains their response to disturbances.

Consequently, SRM-0017 establishes the error-and-residual layer required for mathematically certified SMOF transition execution.

---


**End of SRM-0017**
