# PT-0002 — Operator Composition Theorem

**Document Identifier:** PT-0002

**Title:** Operator Composition Theorem

**Classification:** Foundational Theorem

**Programme:** Mathematical Proof Programme (MPP)

**Layer:** Certified Mathematical Foundation (CMF)

**Status:** Draft

**Version:** 1.0

**Authority:** SMOF Constitution

**Governing Standard:** SCS-0001 Foundation Audit Framework

**Dependencies:**

- PA-0001 — Primitive Sufficiency Axiom
- PL-0001 — Operator Closure Lemma
- FC-0003 — MathematicalOperator

---

# 1. Purpose

This theorem establishes the formal composition rule for certified MathematicalOperators within the State-Manifold Operator Framework (SMOF).

It establishes that when two certified MathematicalOperators are mathematically composable, their composition is itself a valid MathematicalOperator.

The theorem formalizes operator composition as a certified construction within the SMOF Mathematical Proof Programme.

---

# 2. Scope

This theorem applies to certified MathematicalOperators whose domains and codomains satisfy the mathematical compatibility conditions required for composition.

It establishes the composition relationship between two operators and the resulting composite operator.

---

# 3. Mathematical Setting

Let \(X\), \(Y\), and \(Z\) be mathematical state spaces.

Let

\[
P_1:X\rightarrow Y
\]

and

\[
P_2:Y\rightarrow Z.
\]

Then the codomain of \(P_1\) is compatible with the domain of \(P_2\).

---

# 4. Composition Definition

The composition of \(P_1\) and \(P_2\) is defined by

\[
(P_2\circ P_1)(x)=P_2(P_1(x)).
\]

Therefore,

\[
P_2\circ P_1:X\rightarrow Z.
\]

The first operator is applied to the input state and produces an intermediate state in \(Y\).

The second operator then acts upon that intermediate state and produces an output state in \(Z\).

---

# 5. Compatibility Condition

Composition is valid when

\[
\operatorname{Cod}(P_1)\subseteq\operatorname{Dom}(P_2).
\]

The equality condition

\[
\operatorname{Cod}(P_1)=\operatorname{Dom}(P_2)
\]

is therefore a sufficient special case.

The inclusion condition is the more general composition requirement.

---

# 6. Theorem Statement

**Theorem PT-0002.**

Let \(P_1\) and \(P_2\) be certified MathematicalOperators such that

\[
P_1:X\rightarrow Y
\]

and

\[
P_2:Y\rightarrow Z.
\]

If

\[
\operatorname{Cod}(P_1)\subseteq\operatorname{Dom}(P_2),
\]

then the composite operator

\[
P_2\circ P_1:X\rightarrow Z
\]

exists and is itself a valid MathematicalOperator.

---

# 7. Proof

Let \(x\in X\).

Because

\[
P_1:X\rightarrow Y,
\]

the value

\[
P_1(x)
\]

belongs to \(Y\).

By the compatibility condition,

\[
\operatorname{Cod}(P_1)\subseteq\operatorname{Dom}(P_2).
\]

Therefore \(P_1(x)\) belongs to the domain on which \(P_2\) is defined.

Consequently,

\[
P_2(P_1(x))
\]

is well-defined.

Define the composite mapping

\[
P_2\circ P_1:X\rightarrow Z
\]

by

\[
(P_2\circ P_1)(x)=P_2(P_1(x)).
\]

Since both \(P_1\) and \(P_2\) are certified MathematicalOperators and their composition is a mathematically valid transformation from \(X\) to \(Z\), the resulting composite satisfies the defining requirement for a MathematicalOperator.

Therefore,

\[
P_2\circ P_1
\]

is a valid MathematicalOperator.

\[
\boxed{P_2\circ P_1:X\rightarrow Z}
\]

QED.

---

# 8. Relationship to PL-0001

PL-0001 establishes operator closure under valid composition.

PT-0002 specializes that closure result into a formal theorem concerning the composition of certified MathematicalOperators.

Thus:

\[
PL\text{-}0001
\Longrightarrow
PT\text{-}0002.
\]

The lemma establishes the closure property, while this theorem establishes the resulting compositional operator structure.

---

# 9. Relationship to PA-0001

PA-0001 establishes the primitive mathematical vocabulary

\[
\mathcal{P}=\{E,O,P,R\}.
\]

MathematicalOperator \(P\) is therefore part of the accepted primitive basis.

PT-0002 does not introduce a new primitive.

Instead, it derives a higher-order operator through certified composition of existing MathematicalOperators.

Thus operator composition is a derived construction rather than an additional primitive.

---

# 10. Associativity of Composition

For three compatible operators

\[
P_1:X\rightarrow Y,
\]

\[
P_2:Y\rightarrow Z,
\]

and

\[
P_3:Z\rightarrow W,
\]

the corresponding compositions satisfy

\[
P_3\circ(P_2\circ P_1)
=
(P_3\circ P_2)\circ P_1.
\]

For every \(x\in X\),

\[
P_3((P_2\circ P_1)(x))
=
P_3(P_2(P_1(x))),
\]

and

\[
((P_3\circ P_2)\circ P_1)(x)
=
P_3(P_2(P_1(x))).
\]

Therefore the two compositions agree on every element of their common domain.

This establishes associativity of valid operator composition.

---

# 11. Identity Operators

For each suitable state space \(X\), define an identity operator

\[
I_X:X\rightarrow X
\]

such that

\[
I_X(x)=x.
\]

Then for every compatible operator

\[
P:X\rightarrow Y,
\]

the following relations hold:

\[
P\circ I_X=P
\]

and

\[
I_Y\circ P=P.
\]

Thus identity operators provide the neutral elements for operator composition.

---

# 12. Closure Consequence

The theorem establishes that valid compositions of certified MathematicalOperators remain within the MathematicalOperator domain.

Therefore repeated composition produces operators of the form

\[
P_n\circ P_{n-1}\circ\cdots\circ P_2\circ P_1.
\]

Provided every consecutive pair satisfies the required domain/codomain compatibility condition, the complete composition remains a valid MathematicalOperator.

---

# 13. Execution Interpretation

The mathematical composition

\[
P_2\circ P_1
\]

corresponds to the ordered execution:

\[
x
\xrightarrow{P_1}
P_1(x)
\xrightarrow{P_2}
P_2(P_1(x)).
\]

This establishes the mathematical basis for representing operator execution as a directed composition graph.

The execution order is therefore determined by the mathematical dependency relation between operators.

---

# 14. Certification Consequence

A proposed composite operator may be certified only after establishing:

1. \(P_1\) is a certified MathematicalOperator;
2. \(P_2\) is a certified MathematicalOperator;
3. the codomain of \(P_1\) is compatible with the domain of \(P_2\);
4. the composite mapping is mathematically well-defined;
5. the resulting mapping satisfies the MathematicalOperator contract.

Certification therefore follows mathematical validity rather than replacing it.

---

# 15. Engineering Consequence

SMOF implementations may represent composite operations through operator composition rather than introducing a new foundational primitive for every composite behaviour.

This supports:

- operator pipelines;
- execution graphs;
- mathematical transformation chains;
- reusable operator libraries;
- compositional runtime semantics;
- certified higher-order operators.

The implementation must remain subordinate to the mathematical specification.

---

# 16. Non-Composition Case

If

\[
\operatorname{Cod}(P_1)\not\subseteq\operatorname{Dom}(P_2),
\]

then

\[
P_2\circ P_1
\]

is not defined under the stated composition rule.

Therefore no certified composite operator may be constructed from \(P_1\) and \(P_2\) without an additional mathematically justified compatibility transformation.

This prevents invalid operator composition from entering the certified mathematical system.

---

# 17. Derived Research Objectives

PT-0002 provides the basis for subsequent results concerning:

- operator algebra;
- execution graphs;
- identity operators;
- associative operator composition;
- operator pipelines;
- composite runtime execution;
- categorical interpretation of SMOF operators;
- higher-order operator construction.

---

# 18. Constitutional Alignment

PT-0002 implements the constitutional principles that:

- mathematics precedes implementation;
- operators are constitutionally defined mathematical transformations;
- composition is preferred over primitive expansion;
- certification follows mathematical correctness;
- higher-order structures are derived from accepted primitives.

---

# 19. Certification Status

**Identifier:** PT-0002

**Classification:** Foundational Theorem

**Programme:** Mathematical Proof Programme

**Layer:** Certified Mathematical Foundation

**Status:** Draft

**Version:** 1.0

**Dependencies:**

\[
PA\text{-}0001
\rightarrow
PL\text{-}0001
\rightarrow
PT\text{-}0002
\]

---

# 20. Certification Note

PT-0002 establishes that compatible certified MathematicalOperators compose into a valid certified MathematicalOperator.

The theorem does not introduce a new primitive.

It establishes a derived compositional structure from the accepted MathematicalOperator primitive and the closure property established by PL-0001.

The theorem therefore provides a formal mathematical basis for operator pipelines, execution graphs, composite transformations, and higher-order SMOF operator structures.

---

# 21. Canonical Location

`docs/canon/proofs/theorems/PT-0002-Operator-Composition-Theorem.md`
