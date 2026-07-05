"""
SMOF Reference Mathematical Kernel (SRMK)

Module:
    smof.constitution

Purpose
-------
Defines the immutable identity of the SMOF Constitution.

This module provides the canonical constitutional metadata,
the public Constitution API,
and establishes the root constitutional specification upon
which every SMOF component depends.

Mathematical Specification
--------------------------
Let

    C = (N, V, A)

where

    N = Constitution name
    V = Constitution version
    A = Set of constitutional articles

The Constitution operator

    𝓒 : ∅ → C

is immutable and deterministic.

Engineering Constitution
------------------------
Article I    - Mathematics is the Specification
Article II   - Constitutional Authority
Article V    - Operator Purity
Article XI   - Dual Documentation
Article XIV  - Documentation First
Article XV   - Stability
Article XVI  - Open Science
Article XVII - Version Evolution

SEP
---
SEP-0001
Constitution Core

SVP
---
SVP-0001
Constitution Validation
"""

from __future__ import annotations

from typing import Final

##############################################################################
# Constitution Identity
##############################################################################

CONSTITUTION_NAME: Final[str] = (
    "SMOF Mathematical Constitution"
)

CONSTITUTION_VERSION: Final[str] = "1.0"

##############################################################################
# Constitutional Metadata
##############################################################################

CONSTITUTION_AUTHORITY: Final[str] = (
    "SMOF Reference Mathematical Kernel"
)

CONSTITUTION_STATUS: Final[str] = "Active"

##############################################################################
# Constitutional Registry
##############################################################################

ARTICLES: Final[tuple[str, ...]] = ()

##############################################################################
# Public API
##############################################################################

__all__ = [
    "CONSTITUTION_NAME",
    "CONSTITUTION_VERSION",
    "CONSTITUTION_AUTHORITY",
    "CONSTITUTION_STATUS",
    "ARTICLES",
    "constitution_info",
]


def constitution_info() -> dict[str, object]:
    """
    Return immutable constitutional metadata.
    """

    return {
        "name": CONSTITUTION_NAME,
        "version": CONSTITUTION_VERSION,
        "authority": CONSTITUTION_AUTHORITY,
        "status": CONSTITUTION_STATUS,
        "articles": ARTICLES,
    }
