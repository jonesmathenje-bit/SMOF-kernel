"""
SMOF Reference Mathematical Kernel (SRMK)

Module:
    smof.version

Purpose
-------
Provides the immutable identity of the SMOF Reference Mathematical Kernel.

This module defines the canonical version information for the kernel and
establishes the public version API that every downstream SMOF component
depends upon.

Mathematical Specification
--------------------------
Define the kernel version as the immutable tuple

    V = (M, m, p, s, b)

where

    M = major version
    m = minor version
    p = patch version
    s = release stage
    b = build metadata

The version operator

    𝓥 : ∅ → V

is a constant operator.

It has no side effects,
no mutable state,
and is deterministic.

Engineering Constitution
------------------------
Article I   - Mathematics is the Specification
Article V   - Operator Purity
Article XI  - Dual Documentation
Article XIV - Documentation First
Article XV  - Stability
Article XVI - Open Science
Article XVII- Version Evolution

SEP
---
SEP-0000B
Bootstrap Layer

SVP
---
SVP-0000B
Bootstrap Validation
"""

from __future__ import annotations

from typing import Final


###########################################################################
# Kernel Identity
###########################################################################

KERNEL_NAME: Final[str] = "SMOF Reference Mathematical Kernel"

###########################################################################
# Semantic Version
###########################################################################

MAJOR: Final[int] = 0
MINOR: Final[int] = 1
PATCH: Final[int] = 0

VERSION: Final[tuple[int, int, int]] = (
    MAJOR,
    MINOR,
    PATCH,
)

###########################################################################
# Release Information
###########################################################################

RELEASE_STAGE: Final[str] = "alpha"

BUILD_METADATA: Final[str] = "1"

API_VERSION: Final[str] = "0.1"

###########################################################################
# Canonical Version String
###########################################################################

__version__: Final[str] = (
    f"{MAJOR}.{MINOR}.{PATCH}"
    f"-{RELEASE_STAGE}.{BUILD_METADATA}"
)

###########################################################################
# Public API
###########################################################################

__all__ = [
    "KERNEL_NAME",
    "VERSION",
    "__version__",
    "API_VERSION",
    "RELEASE_STAGE",
    "BUILD_METADATA",
    "version_info",
]


def version_info() -> dict[str, object]:
    """
    Return immutable kernel version information.

    Returns
    -------
    dict
        Dictionary describing the kernel identity.

    Notes
    -----
    This function is deterministic.

    Repeated invocations produce identical results.

    The returned information forms part of the public API defined
    by SEP-0000B.
    """

    return {
        "kernel": KERNEL_NAME,
        "major": MAJOR,
        "minor": MINOR,
        "patch": PATCH,
        "version": __version__,
        "version_tuple": VERSION,
        "api_version": API_VERSION,
        "release_stage": RELEASE_STAGE,
        "build_metadata": BUILD_METADATA,
    }
