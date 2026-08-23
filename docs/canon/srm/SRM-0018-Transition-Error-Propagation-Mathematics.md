# SRM-0018 — Transition Error Propagation Mathematics

**Document Identifier:** SRM-0018

**Title:** Transition Error Propagation Mathematics

**Classification:** SMOF Runtime Mathematics

**Programme:** SMOF Runtime Mathematics (SRM)

**Layer:** Certified Mathematical Foundation / Runtime Mathematics

**Status:** Draft

**Version:** 1.0

**Authority:** SMOF Constitution

**Governing Standard:** SCS-0001 Foundation Audit Framework

---

# 1. Purpose

SRM-0018 establishes the mathematical basis for analysing the propagation of transition error through successive SMOF state transitions.

SRM-0017 establishes the mathematical concepts of transition error and residual. Given an exact transition evolution and an observed, approximate, perturbed, or computationally realised transition evolution, a discrepancy may arise between the two corresponding state trajectories.

SRM-0018 establishes how such discrepancies evolve under successive transition operators.

The purpose of this specification is to define transition error propagation, local transition error, propagated error, cumulative error, error amplification, error attenuation, bounded error propagation, and composition-level error behaviour within the SMOF Runtime Mathematics programme.

---

# 2. Scope

This specification applies to:

- MathematicalRuntime;
- MathematicalObject state evolution;
- MathematicalOperator state transformations;
- deterministic state transitions;
- finite transition compositions;
- approximate transition execution;
- perturbation-sensitive state evolution;
- transition error analysis;
- residual-based transition analysis;
- runtime execution correspondence;
- certified runtime mathematics.

This specification builds upon the mathematical structures established by the preceding SRM specifications.

---

# 3. Normative References

This specification derives authority from:

- SMOF Constitution;
- SMOF Canon;
- FC-0001 MathematicalEntity;
- FC-0002 MathematicalObject;
- FC-0003 MathematicalOperator;
- FC-0004 MathematicalRuntime;
- PA-0001 Primitive Sufficiency Axiom;
- PL-0001 Operator Closure Lemma;
- PT-0001 Primitive Sufficiency Theorem;
- PT-0002 Operator Composition Theorem;
- PT-0003 Runtime Correctness Theorem;
- PT-0004 Execution Graph Correctness Theorem;
- PT-0005 Foundation Completeness Theorem;
- SRM-0001 Runtime Mathematical Foundation;
- SRM-0002 Runtime Transition;
- SRM-0003 State Transition Mathematics;
- SRM-0004 Transition Composition Mathematics;
- SRM-0005;
- SRM-0006;
- SRM-0007 Transition Reachability and Orbit Mathematics;
- SRM-0008;
- SRM-0009;
- SRM-0010;
- SRM-0011;
- SRM-0012;
- SRM-0013;
- SRM-0014 Transition Convergence Mathematics;
- SRM-0015 Transition Perturbation Mathematics;
- SRM-0016 Transition Convergence Rate Mathematics;
- SRM-0017 Transition Error and Residual Mathematics;
- SCS-0001 Foundation Audit Framework.

---

# 4. Mathematical Context

Let the exact SMOF state transition be defined by

\[
S_{i+1}=P_i(S_i),
\]

where:

- \(S_i\) is the state at transition index \(i\);
- \(P_i\) is a valid MathematicalOperator;
- \(S_{i+1}\) is the resulting state.

Let an approximate or realised transition evolution be denoted by

\[
\widehat{S}_{i+1}=\widehat{P}_i(\widehat{S}_i).
\]

The corresponding transition error is the discrepancy between the exact and realised state trajectories.

Define the transition error at index \(i\) by

\[
e_i=d(S_i,\widehat{S}_i),
\]

where \(d\) is a valid state-distance, metric, seminorm-induced distance, norm, or other certified discrepancy measure appropriate to the mathematical state space.

The objective of transition error propagation mathematics is to determine how \(e_i\) evolves under successive transitions.

---

# 5. Exact and Approximate State Evolution

The exact state evolution is given by

\[
S_{i+1}=P_i(S_i).
\]

The approximate evolution is given by

\[
\widehat{S}_{i+1}
=
\widehat{P}_i(\widehat{S}_i).
\]

Therefore,

\[
e_{i+1}
=
d
\left(
P_i(S_i),
\widehat{P}_i(\widehat{S}_i)
\right).
\]

This quantity represents the propagated transition error after the \(i\)-th transition.

---

# 6. Local Transition Error

## 6.1 Definition

The Local Transition Error is the error introduced by a transition operator when acting on a common input state.

Define the local transition error by

\[
\ell_i(S)
=
d
\left(
P_i(S),
\widehat{P}_i(S)
\right).
\]

The quantity \(\ell_i(S)\) measures the discrepancy attributable directly to the realised or approximate operator relative to the exact operator.

---

## 6.2 Interpretation

The local transition error is distinguished from propagated state error.

Local transition error answers the question:

> How much error is introduced by the transition itself when both exact and approximate operators receive the same input?

Propagated state error answers the question:

> How much discrepancy exists between the exact and approximate states after prior transition errors have already influenced the input?

The total error evolution may contain both effects.

---

# 7. Transition Error Decomposition

Consider

\[
e_{i+1}
=
d
\left(
P_i(S_i),
\widehat{P}_i(\widehat{S}_i)
\right).
\]

By introducing the intermediate quantity

\[
P_i(\widehat{S}_i),
\]

the transition error may be decomposed into state-propagation and operator-realisation components.

Using the triangle inequality, where applicable,

\[
e_{i+1}
\leq
d
\left(
P_i(S_i),
P_i(\widehat{S}_i)
\right)
+
d
\left(
P_i(\widehat{S}_i),
\widehat{P}_i(\widehat{S}_i)
\right).
\]

Therefore,

\[
e_{i+1}
\leq
\text{propagated state error}
+
\text{local transition error}.
\]

This decomposition is fundamental to SRM-0018.

---

# 8. Transition Error Propagation

## 8.1 Definition

Transition Error Propagation is the mathematical evolution of a state discrepancy through successive transition operators.

For a transition sequence

\[
S_{i+1}=P_i(S_i),
\]

with approximate sequence

\[
\widehat{S}_{i+1}
=
\widehat{P}_i(\widehat{S}_i),
\]

the error propagation sequence is

\[
e_0,e_1,e_2,\ldots,e_n.
\]

---

## 8.2 Error Propagation Function

Define an Error Propagation Function

\[
\mathcal{E}_i
\]

such that

\[
e_{i+1}
\leq
\mathcal{E}_i(e_i,\ell_i).
\]

The function \(\mathcal{E}_i\) characterises the manner in which existing state error and newly introduced local transition error combine.

---

# 9. Lipschitz Transition Bound

Suppose \(P_i\) is Lipschitz continuous with constant \(L_i\), such that

\[
d
\left(
P_i(X),
P_i(Y)
\right)
\leq
L_i d(X,Y).
\]

Then

\[
d
\left(
P_i(S_i),
P_i(\widehat{S}_i)
\right)
\leq
L_i e_i.
\]

Consequently,

\[
e_{i+1}
\leq
L_i e_i
+
\ell_i(\widehat{S}_i).
\]

This provides a basic recurrence relation for transition error propagation.

---

# 10. Error Amplification

## 10.1 Definition

A transition exhibits Error Amplification when existing state error may increase under transition application.

For a Lipschitz constant

\[
L_i>1,
\]

the propagated component satisfies

\[
L_i e_i>e_i
\]

for every positive \(e_i\).

Thus, prior error may be amplified.

---

## 10.2 Interpretation

Error amplification does not necessarily imply invalidity of a transition.

It identifies a mathematical sensitivity property of the transition with respect to perturbations or discrepancies in its input state.

---

# 11. Error Attenuation

## 11.1 Definition

A transition exhibits Error Attenuation when existing state error decreases under transition application.

If

\[
0\leq L_i<1,
\]

then

\[
L_i e_i<e_i
\]

for every positive \(e_i\).

The transition therefore attenuates the propagated component of existing error.

---

## 11.2 Contractive Transition Error Propagation

## 11.3 One-Step Error Propagation

For a single transition, the Lipschitz transition bound and the transition-error decomposition give

\[
e_{i+1}
\leq
L_i e_i+\ell_i(\widehat{S}_i).
\]

This inequality defines the one-step propagation of existing state error together with newly introduced local transition error.

The term

\[
L_i e_i
\]

represents propagation of previously existing error, while

\[
\ell_i(\widehat{S}_i)
\]

represents local error introduced by the realised transition.

Therefore, one-step transition error propagation is governed by

\[
e_{i+1}
\leq
L_i e_i+\ell_i(\widehat{S}_i).
\]

---

## 11.4 Multi-Step Error Propagation

Consider a finite sequence of transitions indexed by

\[
i=0,1,\ldots,n-1.
\]

Applying the one-step propagation inequality successively gives

\[
e_{i+1}
\leq
L_i e_i+\ell_i(\widehat{S}_i).
\]

Repeated substitution yields the multi-step bound

\[
e_n
\leq
\left(
\prod_{k=0}^{n-1}L_k
\right)e_0
+
\sum_{j=0}^{n-1}
\left(
\prod_{k=j+1}^{n-1}L_k
\right)
\ell_j(\widehat{S}_j),
\]

with the convention that an empty product is equal to \(1\).

Thus, initial error is propagated through the product of transition Lipschitz factors, while each local transition error is propagated through all subsequent transition factors.

---

## 11.5 Recursive Error Relation

The one-step transition-error bound induces the recursive relation

\[
e_{i+1}
\leq
L_i e_i+\ell_i(\widehat{S}_i).
\]

Equivalently, defining the error-propagation recurrence by

\[
\mathcal{R}_i(e_i)
=
L_i e_i+\ell_i(\widehat{S}_i),
\]

the transition error satisfies

\[
e_{i+1}\leq\mathcal{R}_i(e_i).
\]

The recursive relation provides the local-to-global mechanism by which transition errors propagate through a finite transition sequence.

---

## 11.6 Error Neutrality

Error neutrality concerns the propagation of existing error independently of newly introduced local transition error.

A transition is propagation-neutral when

\[
L_i=1.
\]

In this case, the one-step relation becomes

\[
e_{i+1}
\leq
e_i+\ell_i(\widehat{S}_i).
\]

Therefore, the transition neither amplifies nor attenuates the existing error through its Lipschitz propagation factor.

If, in addition,

\[
\ell_i(\widehat{S}_i)=0,
\]

then

\[
e_{i+1}\leq e_i,
\]

and the transition introduces no additional local error.

Error neutrality therefore distinguishes preservation of existing error magnitude from the separate question of whether new local transition error is introduced.
If

\[
L_i\leq \lambda<1
\]

for all transitions in a sequence, then the propagated component of the error decreases geometrically.

This provides a direct mathematical connection between transition error propagation and transition convergence.

---

# 12. Neutral Error Propagation

A transition is neutral with respect to propagated error magnitude when

\[
L_i=1.
\]

In this case,

\[
e_{i+1}
\leq
e_i+\ell_i(\widehat{S}_i).
\]

The transition does not amplify the existing error through its propagation factor, although additional local error may still accumulate.

---

# 13. Cumulative Error Propagation

For a sequence of transitions satisfying

\[
e_{i+1}
\leq
L_i e_i+\ell_i,
\]

recursive substitution yields

\[
e_n
\leq
\left(
\prod_{k=0}^{n-1}L_k
\right)e_0
+
\sum_{j=0}^{n-1}
\left(
\prod_{k=j+1}^{n-1}L_k
\right)
\ell_j.
\]

The empty product is defined as the identity scalar.

This expression separates:

1. propagated initial error; and
2. accumulated local transition errors.

---

# 14. Uniform Error Bound

Suppose

\[
L_i\leq L
\]

and

\[
\ell_i\leq\ell
\]

for all \(i\).

Then

\[
e_{i+1}
\leq
Le_i+\ell.
\]

Repeated substitution gives

\[
e_n
\leq
L^n e_0
+
\ell
\sum_{k=0}^{n-1}L^k.
\]

If

\[
L\neq1,
\]

then

\[
e_n
\leq
L^n e_0
+
\ell
\frac{1-L^n}{1-L}.
\]

This provides a uniform finite-horizon error bound.

---

# 15. Bounded Error Propagation

## 15.1 Definition

A transition evolution exhibits Bounded Error Propagation if there exists a finite bound \(B_n\) such that

\[
e_n\leq B_n
\]

for the specified transition horizon.

---

## 15.2 Asymptotic Boundedness

If

\[
0\leq L<1,
\]

then

\[
L^n\rightarrow0.
\]

For uniformly bounded local error,

\[
e_n
\leq
L^n e_0
+
\ell
\frac{1-L^n}{1-L}.
\]

Therefore,

\[
\limsup_{n\rightarrow\infty}e_n
\leq
\frac{\ell}{1-L}.
\]

Thus a contractive transition system with bounded persistent local error may remain within a bounded asymptotic error region.

---

# 16. Error-Free Transition Preservation

If

\[
\ell_i=0
\]

and

\[
e_i=0,
\]

then

\[
e_{i+1}=0.
\]

Therefore, exact transition correspondence preserves zero transition error.

This is the fundamental Error Preservation property.

---

# 17. Transition Composition and Error Propagation

Consider the two-step exact transition

\[
S_{i+2}
=
P_{i+1}
\circ
P_i
(S_i).
\]

Let the approximate evolution be

\[
\widehat{S}_{i+2}
=
\widehat{P}_{i+1}
\circ
\widehat{P}_i
(\widehat{S}_i).
\]

The composite error is

\[
e_{i+2}
=
d
\left(
(P_{i+1}\circ P_i)(S_i),
(\widehat{P}_{i+1}\circ\widehat{P}_i)(\widehat{S}_i)
\right).
\]

The error introduced at the first transition may therefore propagate through the second transition.

Transition composition is consequently also error composition.

---

# 18. Composite Error Propagation Operator

Define a Composite Error Propagation Operator

\[
\mathfrak{E}_{0:n}
\]

such that

\[
e_n
\leq
\mathfrak{E}_{0:n}
(e_0,\ell_0,\ell_1,\ldots,\ell_{n-1}).
\]

The operator \(\mathfrak{E}_{0:n}\) represents the cumulative mathematical effect of a finite transition sequence on the initial error and local transition errors.

---

# 19. Error Propagation and Transition Reachability

SRM-0007 establishes transition reachability and orbit mathematics.

Error propagation extends reachability analysis by distinguishing between:

- exact reachability;
- approximate reachability;
- error-bounded reachability.

A target state \(T\) may be reached exactly when

\[
S_n=T.
\]

Under approximate execution, an error-bounded reachability condition may instead be expressed as

\[
d(\widehat{S}_n,T)
\leq
\varepsilon.
\]

The value of \(\varepsilon\) may be determined or bounded through transition error propagation analysis.

---

# 20. Error Propagation and Convergence

SRM-0014 establishes transition convergence mathematics.

SRM-0016 establishes transition convergence rate mathematics.

Transition error propagation provides the mechanism by which convergence claims are evaluated under approximate or perturbed execution.

If

\[
S_n\rightarrow S_\ast
\]

and

\[
e_n\rightarrow0,
\]

then

\[
\widehat{S}_n\rightarrow S_\ast
\]

under the relevant topology and distance assumptions.

If instead

\[
e_n
\]

remains bounded but does not converge to zero, approximate execution may converge only to an error neighbourhood of the limiting state.

---

# 21. Error Propagation and Perturbation

SRM-0015 establishes transition perturbation mathematics.

A perturbation may enter the runtime transition through:

- state perturbation;
- operator perturbation;
- execution perturbation;
- numerical approximation;
- representation discrepancy.

Transition error propagation provides the mathematical mechanism for tracing the downstream consequences of such perturbations.

A local perturbation at transition \(i\) may influence every subsequent state in the transition sequence.

---

# 22. Residual and Propagated Error

SRM-0017 distinguishes transition error from residual.

A small residual does not automatically imply a small propagated error without additional stability assumptions.

Conversely, a bounded local residual may produce either:

- attenuated downstream error;
- neutral downstream accumulation;
- amplified downstream error.

Therefore, residual analysis and error propagation analysis are complementary rather than identical.

---

# 23. Runtime Correspondence

A MathematicalRuntime executing a transition sequence

\[
S_0
\xrightarrow{P_0}
S_1
\xrightarrow{P_1}
\cdots
\xrightarrow{P_{n-1}}
S_n
\]

may also realise an approximate sequence

\[
\widehat{S}_0
\xrightarrow{\widehat{P}_0}
\widehat{S}_1
\xrightarrow{\widehat{P}_1}
\cdots
\xrightarrow{\widehat{P}_{n-1}}
\widehat{S}_n.
\]

The runtime error semantics shall correspond to the mathematical error sequence

\[
e_i
=
d(S_i,\widehat{S}_i).
\]

A runtime implementation shall not claim certified error preservation unless the corresponding mathematical assumptions are satisfied.

---

# 24. State Transition Graph

Let a State Transition Graph be represented by

\[
\mathcal{G}
=
(V,E),
\]

where:

- \(V\) is the set of valid states;
- \(E\) is the set of valid transitions.

Error propagation may be associated with paths in the graph.

For a path

\[
\pi
=
(P_0,P_1,\ldots,P_{n-1}),
\]

the path error evolution is

\[
e_0
\mapsto
e_1
\mapsto
\cdots
\mapsto
e_n.
\]

Different transition paths may therefore possess different error propagation characteristics even when they connect the same initial and terminal states.

---

# 25. Error Propagation Stability

## 25.1 Definition

A transition sequence is Error Propagation Stable over a specified horizon when sufficiently bounded initial and local errors remain bounded under the sequence.

---

## 25.2 Stability Condition

A sufficient condition is the existence of finite constants \(B_0,\ldots,B_n\) such that

\[
e_i\leq B_i
\]

for every transition index in the certified execution horizon.

---

# 26. Transition Error Propagation Preservation

## Proposition

Let

\[
e_i=0
\]

and suppose

\[
\ell_i(\widehat{S}_i)=0.
\]

Then

\[
e_{i+1}=0.
\]

### Proof

If \(e_i=0\), then

\[
S_i=\widehat{S}_i
\]

under a separating distance measure.

If the local transition error is zero, then

\[
P_i(\widehat{S}_i)
=
\widehat{P}_i(\widehat{S}_i).
\]

Therefore,

\[
P_i(S_i)
=
\widehat{P}_i(\widehat{S}_i).
\]

Hence,

\[
e_{i+1}=0.
\]

Therefore zero error is preserved by an exact corresponding transition.

QED.

---

# 27. Transition Error Propagation Theorem

## Theorem

Let a finite SMOF transition sequence satisfy

\[
e_{i+1}
\leq
L_i e_i+\ell_i
\]

for every transition index

\[
i=0,\ldots,n-1.
\]

Then the terminal transition error satisfies

\[
e_n
\leq
\left(
\prod_{k=0}^{n-1}L_k
\right)e_0
+
\sum_{j=0}^{n-1}
\left(
\prod_{k=j+1}^{n-1}L_k
\right)
\ell_j.
\]

Consequently, terminal transition error is determined by the propagated initial error together with the propagated accumulation of local transition errors.

### Proof

The result follows by repeated recursive substitution of

\[
e_{i+1}
\leq
L_i e_i+\ell_i.
\]

For the first transition,

\[
e_1
\leq
L_0e_0+\ell_0.
\]

For the second transition,

\[
e_2
\leq
L_1e_1+\ell_1.
\]

Substituting the preceding inequality gives

\[
e_2
\leq
L_1L_0e_0
+
L_1\ell_0
+
\ell_1.
\]

Continuing inductively yields the general finite-horizon expression.

QED.

---

# 28. Main Result

The central result of SRM-0018 is:

> Transition error propagates through a valid SMOF transition sequence according to both the sensitivity of successive transition operators to existing state discrepancy and the accumulation of local transition error introduced during execution.

Under Lipschitz transition assumptions,

\[
e_{i+1}
\leq
L_i e_i+\ell_i.
\]

For finite transition compositions, the terminal error is bounded by the propagated initial error together with the propagated accumulation of local transition errors.

Thus transition composition, perturbation, convergence, residual behaviour, and runtime correspondence are mathematically connected through transition error propagation.

---

# 29. Limitations

The results of this specification depend upon the mathematical assumptions under which they are applied.

In particular:

- a suitable state discrepancy measure must be defined;
- triangle-inequality arguments require an appropriate metric or norm structure;
- Lipschitz bounds require the relevant continuity assumptions;
- finite-horizon bounds do not automatically establish infinite-horizon stability;
- bounded local error does not imply convergence to zero;
- residual bounds do not automatically imply state-error bounds;
- nonlinear transitions may require local rather than global propagation constants;
- stochastic transition error requires additional probabilistic mathematics;
- infinite-dimensional state spaces may require additional functional-analytic assumptions.

No stronger conclusion shall be inferred without the required additional hypotheses.

---

# 30. Consequences

SRM-0018 establishes that:

- transition error can be analysed recursively;
- existing state error and local transition error are mathematically distinguishable;
- transition operators may amplify, preserve, or attenuate existing error;
- finite transition compositions possess cumulative error bounds;
- contractive transitions provide error attenuation conditions;
- bounded local error may generate bounded asymptotic error;
- transition paths may be compared according to error propagation characteristics;
- runtime certification claims concerning error require explicit mathematical assumptions;
- transition convergence analysis is strengthened by error propagation mathematics.

---

# 31. Dependency Chain

The dependency structure of this specification is:

\[
PA\text{-}0001
\]

\[
\downarrow
\]

\[
PL\text{-}0001
\]

\[
\downarrow
\]

\[
PT\text{-}0001
\rightarrow
PT\text{-}0002
\rightarrow
PT\text{-}0003
\rightarrow
PT\text{-}0004
\rightarrow
PT\text{-}0005
\]

\[
\downarrow
\]

\[
SRM\text{-}0001
\rightarrow
SRM\text{-}0002
\rightarrow
SRM\text{-}0003
\rightarrow
SRM\text{-}0004
\]

\[
\downarrow
\]

\[
SRM\text{-}0007
\]

\[
\downarrow
\]

\[
SRM\text{-}0014
\rightarrow
SRM\text{-}0015
\rightarrow
SRM\text{-}0016
\rightarrow
SRM\text{-}0017
\]

\[
\downarrow
\]

\[
\boxed{
SRM\text{-}0018
}
\]

SRM-0018 depends specifically on the prior definitions of state transition, transition composition, perturbation, convergence, convergence rate, transition error, and residual mathematics.

---

# 32. Constitutional Alignment

SRM-0018 is aligned with the constitutional principles that:

- mathematics precedes implementation;
- runtime behaviour requires mathematical definition;
- operators govern state transformation;
- composition governs system evolution;
- certified execution requires explicit semantics;
- higher-order behaviour is derived through composition;
- mathematical claims require stated assumptions;
- certification follows auditable mathematical structure.

---

# 33. Governance

Any modification to the mathematical definitions, recurrence relations, preservation results, or theorem statements defined by SRM-0018 shall require:

1. documented mathematical justification;
2. dependency analysis;
3. review against preceding SRM specifications;
4. Foundation Audit;
5. certification review;
6. canonical publication.

No implementation convention shall silently alter the mathematical meaning of transition error propagation.

---

# 34. Theorem Status

**Primary Proposition:** Transition Error Propagation Preservation

**Primary Theorem:** Transition Error Propagation Theorem

**Status:** Draft

The proposition and theorem are established within the assumptions explicitly stated by this specification.

---

# 35. Certification Note

SRM-0018 establishes the certified mathematical framework for analysing how transition discrepancies evolve through finite SMOF state-transition sequences.

The specification distinguishes local transition error from propagated state error and establishes recurrence relations for cumulative error propagation.

Certification of a specific runtime implementation requires additional verification that its execution semantics satisfy the assumptions and mathematical relations defined herein.

---

# 36. Foundation Status

**Identifier:** SRM-0018

**Classification:** SMOF Runtime Mathematics

**Programme:** SMOF Runtime Mathematics

**Layer:** Certified Mathematical Foundation / Runtime Mathematics

**Status:** Draft

**Version:** 1.0

**Authority:** SMOF Constitution

**Canonical Location:**

`docs/canon/srm/SRM-0018-Transition-Error-Propagation-Mathematics.md`

---

# 37. QED

The mathematical framework for transition error propagation has been defined.

For finite transition sequences satisfying the stated assumptions, terminal transition error is bounded by the propagation of initial error together with the cumulative propagation of local transition errors.

QED.