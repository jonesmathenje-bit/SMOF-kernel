"""
SMOF Reference Mathematical Kernel (SRMK)

Module
------
    smof.definition

Purpose
-------
Defines the immutable Definition object.

A Definition is the fundamental semantic object of the
SMOF Mathematical Kernel.

Definitions establish the precise meaning of mathematical
concepts used throughout the kernel.

Every Axiom, Theorem, Proof, Operator, Contract,
Specification and Algorithm ultimately depends upon
one or more Definitions.

Mathematical Specification
--------------------------

Define a Definition as

    D = (I, N, T, S, F, R, Σ)

where

    I = immutable identifier
    N = definition number
    T = defined term
    S = short statement
    F = formal definition
    R = revision
    Σ = status

The Definition operator

    𝓓 : ∅ → D

is immutable.

Repeated evaluation produces identical results.

Engineering Constitution
------------------------

Article I
    Mathematics is the Specification

Article II
    Constitutional Authority

Article V
    Operator Purity

Article XI
    Dual Documentation

Article XIV
    Documentation First

Article XV
    Stability

Article XVI
    Open Science

Article XVII
    Version Evolution

SEP
---

SEP-0003

Definition Object

SVP
---

SVP-0003

Definition Validation
"""

from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import Final


###############################################################################
# Definition Status
###############################################################################


class DefinitionStatus(str, Enum):
    """
    Supported Definition states.
    """

    ACTIVE = "Active"
    DRAFT = "Draft"
    DEPRECATED = "Deprecated"
    SUPERSEDED = "Superseded"


###############################################################################
# Definition Object
###############################################################################


@dataclass(frozen=True, slots=True)
class Definition:
    """
    Immutable mathematical Definition.
    """

    identifier: str
    number: int
    term: str
    statement: str
    formal_definition: str
    revision: str = "1.0"
    status: DefinitionStatus = DefinitionStatus.ACTIVE

    ###########################################################################
    # Validation
    ###########################################################################

    def __post_init__(self) -> None:

        if not self.identifier.strip():
            raise ValueError("identifier cannot be empty")

        if self.number <= 0:
            raise ValueError("number must be positive")

        if not self.term.strip():
            raise ValueError("term cannot be empty")

        if not self.statement.strip():
            raise ValueError("statement cannot be empty")

        if not self.formal_definition.strip():
            raise ValueError("formal_definition cannot be empty")

        if not self.revision.strip():
            raise ValueError("revision cannot be empty")

    ###########################################################################
    # Behaviour
    ###########################################################################

    def is_active(self) -> bool:
        return self.status == DefinitionStatus.ACTIVE

    def summary(self) -> str:
        return f"{self.identifier}: {self.term}"

    def validate(self) -> bool:
        return True

    ###########################################################################
    # Serialization
    ###########################################################################

    def to_dict(self) -> dict[str, object]:

        return {
            "identifier": self.identifier,
            "number": self.number,
            "term": self.term,
            "statement": self.statement,
            "formal_definition": self.formal_definition,
            "revision": self.revision,
            "status": self.status.value,
        }

    ###########################################################################
    # String Representation
    ###########################################################################

    def __str__(self) -> str:
        return self.summary()

    def __repr__(self) -> str:

        return (
            "Definition("
            f"identifier={self.identifier!r}, "
            f"number={self.number!r}, "
            f"term={self.term!r}, "
            f"revision={self.revision!r}, "
            f"status={self.status.value!r})"
        )


###############################################################################
# Module Constants
###############################################################################

DEFAULT_REVISION: Final[str] = "1.0"

MODULE_NAME: Final[str] = "smof.definition"

OBJECT_NAME: Final[str] = "Definition"

###############################################################################
# Public API
###############################################################################

__all__ = [
    "Definition",
    "DefinitionStatus",
    "DEFAULT_REVISION",
    "MODULE_NAME",
    "OBJECT_NAME",
]
