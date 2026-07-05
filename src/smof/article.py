"""
SMOF Reference Mathematical Kernel (SRMK)

Module:
    smof.article

Purpose
-------
Defines the immutable constitutional Article object.

An Article is the fundamental constitutional object within the
SMOF Mathematical Constitution. Every higher-level mathematical
entity (Definition, Axiom, Theorem, Proof, Operator, Contract, etc.)
is ultimately derived from or governed by Articles.

Mathematical Specification
--------------------------
Define an Article as

    A = (I, N, T, B, R, S)

where

    I = immutable identifier
    N = article number
    T = title
    B = body (constitutional text)
    R = revision
    S = status

The Article operator

    𝓐 : ∅ → A

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
SEP-0002
Article Object

SVP
---
SVP-0002
Article Validation
"""

from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import Final


class ArticleStatus(str, Enum):
    """
    Supported constitutional states.
    """

    ACTIVE = "Active"
    DRAFT = "Draft"
    DEPRECATED = "Deprecated"
    SUPERSEDED = "Superseded"


@dataclass(frozen=True, slots=True)
class Article:
    """
    Immutable constitutional Article.
    """

    identifier: str
    number: int
    title: str
    text: str
    revision: str = "1.0"
    status: ArticleStatus = ArticleStatus.ACTIVE

    def __post_init__(self) -> None:

        if not self.identifier.strip():
            raise ValueError("identifier cannot be empty")

        if self.number <= 0:
            raise ValueError("number must be positive")

        if not self.title.strip():
            raise ValueError("title cannot be empty")

        if not self.text.strip():
            raise ValueError("text cannot be empty")

        if not self.revision.strip():
            raise ValueError("revision cannot be empty")

    def is_active(self) -> bool:
        return self.status == ArticleStatus.ACTIVE

    def summary(self) -> str:
        return f"{self.identifier}: {self.title}"

    def to_dict(self) -> dict[str, object]:

        return {
            "identifier": self.identifier,
            "number": self.number,
            "title": self.title,
            "text": self.text,
            "revision": self.revision,
            "status": self.status.value,
        }

    def validate(self) -> bool:
        return True

    def __str__(self) -> str:
        return self.summary()


##############################################################################
# Public API
##############################################################################

DEFAULT_REVISION: Final[str] = "1.0"

__all__ = [
    "Article",
    "ArticleStatus",
    "DEFAULT_REVISION",
]
