# PL-0001 - Operator Closure Lemma

**Document Identifier:** PL-0001

**Title:** Operator Closure Lemma

**Classification:** Foundational Lemma

**Programme:** Mathematical Proof Programme (MPP)

**Layer:** Certified Mathematical Foundation (CMF)

**Status:** Draft

**Version:** 1.0

**Authority:** SMOF Constitution

**Governing Standard:** SCS-0001 Foundation Audit Framework

**Dependency:** PA-0001 Primitive Sufficiency Axiom

---

# 1. Purpose

This lemma establishes the closure of compatible certified MathematicalOperators under composition.

It provides the first derived mathematical result following the Primitive Sufficiency Axiom.

---

# 2. Scope

This lemma applies to certified MathematicalOperators whose domains and codomains permit valid composition.

It establishes closure only for constitutionally valid and mathematically defined compositions.

---

# 3. Definitions

Let:

\[
\mathcal O
\]

denote the set of certified MathematicalOperators.

Let:

\[
P_1 : X \rightarrow Y
\]

and:

\[
P_2 : Y \rightarrow Z
\]

be certified MathematicalOperators.

Their composition is defined by:

\[
P_2\circ P_1 : X \rightarrow Z
\]

such that:

\[
(P_2\circ P_1)(x)=P_2(P_1(x)).
\]

---

# 4. Compatibility Condition

The composition

\[
P_2\circ P_1
\]

is defined only when:

\[
\operatorname{Cod}(P_1)=\operatorname{Dom}(P_2).
\]

More generally, composition is permitted when the codomain of the first operator is contained within the domain of the second operator.

Thus:

\[
\operatorname{Cod}(P_1)\subseteq\operatorname{Dom}(P_2).
\]

---

# 5. Lemma Statement

**Operator Closure Lemma.**

Let:

\[
P_1,P_2\in\mathcal O
\]

be certified MathematicalOperators satisfying:

\[
\operatorname{Cod}(P_1)\subseteq\operatorname{Dom}(P_2).
\]

Then their composition:

\[
P_2\circ P_1
\]

is a mathematically defined MathematicalOperator.

Therefore:

\[
P_2\circ P_1\in\mathcal O.
\]

---

# 6. Proof

Let:

\[
P_1:X\rightarrow Y
\]

and:

\[
P_2:Y\rightarrow Z.
\]

Because:

\[
\operatorname{Cod}(P_1)\subseteq\operatorname{Dom}(P_2),
\]

the output of \(P_1\) is a valid input to \(P_2\).

For every:

\[
x\in X,
\]

the value:

\[
P_1(x)
\]

exists in the domain of \(P_2\).

Therefore:

\[
P_2(P_1(x))
\]

is defined.

Hence the composition:

\[
P_2\circ P_1:X\rightarrow Z
\]

is a well-defined transformation.

Since both \(P_1\) and \(P_2\) are certified MathematicalOperators and their composition satisfies the mathematical definition of an operator, the resulting composition belongs to the MathematicalOperator domain.

Therefore:

\[
\boxed{P_2\circ P_1\in\mathcal O}.
\]

QED.

---

# 7. Relationship to PA-0001

PA-0001 establishes the primitive vocabulary:

\[
\mathcal P=\{E,O,P,R\}.
\]

The present lemma establishes a closure property for the MathematicalOperator primitive under valid composition.

Thus operator composition does not require introduction of a new foundational primitive.

The resulting operator is a derived construction.

---

# 8. Consequences

The lemma establishes that:

1. compatible MathematicalOperators can be composed;
2. composition produces another MathematicalOperator;
3. operator composition does not expand the primitive vocabulary;
4. higher-order transformations can therefore be constructed through composition;
5. operator composition is compatible with the Primitive Sufficiency Axiom.

---

# 9. Limitations

The lemma does not assert that arbitrary operators are composable.

Composition requires a valid mathematical compatibility condition between the codomain of the first operator and the domain of the second operator.

Therefore:

\[
P_2\circ P_1
\]

is undefined when:

\[
\operatorname{Cod}(P_1)\not\subseteq\operatorname{Dom}(P_2).
\]

---

# 10. Derived Research Objectives

This lemma supports the development of:

## PT-0001

Primitive Sufficiency Theorem

---

## PT-0002

Operator Composition Theorem

---

## PT-0004

Execution Graph Correctness Theorem

---

# 11. Certification Conditions

PL-0001 shall remain a Draft until:

1. its dependency on PA-0001 is validated;
2. its mathematical definitions are reviewed;
3. its proof is independently checked;
4. its relationship to FC-0003 is reviewed;
5. Foundation Audit requirements are satisfied;
6. the resulting proof artifact is certified.

---

# 12. Canonical Location

`docs/canon/proofs/lemmas/PL-0001-Operator-Closure-Lemma.md`

---

# 13. Status

**Identifier:** PL-0001

**Classification:** Foundational Lemma

**Status:** Draft

**Version:** 1.0

**Dependency:** PA-0001

---

# 14. Certification Note

PL-0001 is a derived mathematical result of the SMOF Mathematical Proof Programme.

Its proof establishes closure of compatible certified MathematicalOperators under composition.

Formal certification remains subject to the SMOF Foundation Audit Framework.