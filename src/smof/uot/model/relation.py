from __future__ import annotations

from dataclasses import dataclass
from typing import Final


###############################################################################
# Module Constants
###############################################################################

DEFAULT_RELATION_TYPE: Final[str] = "related_to"

MODULE_NAME: Final[str] = "smof.uot.model.relation"

OBJECT_NAME: Final[str] = "Relation"


###############################################################################
# Relation
###############################################################################


@dataclass(
    frozen=True,
    slots=True,
)
class Relation:
    """
    Immutable Relation.

    Mathematical Form

        R = (s, t, τ)

    where

        s = source identity
        t = target identity
        τ = relation type

    A Relation represents a deterministic connection between two
    canonical identities.
    """

    source: str

    target: str

    relation_type: str = DEFAULT_RELATION_TYPE

    ###########################################################################
    # Validation
    ###########################################################################

    def __post_init__(self) -> None:

        if not self.source.strip():
            raise ValueError("source cannot be empty")

        if not self.target.strip():
            raise ValueError("target cannot be empty")

        if not self.relation_type.strip():
            raise ValueError("relation_type cannot be empty")

    ###########################################################################
    # Behaviour
    ###########################################################################

    def validate(self) -> bool:
        """
        Construction guarantees validity.

        Therefore validation is deterministic.
        """

        return True

    def is_valid(self) -> bool:
        """
        Determine whether the Relation is valid.
        """

        return self.validate()

    def summary(self) -> str:
        """
        Human-readable summary.
        """

        return (
            f"Relation("
            f"{self.source} "
            f"-[{self.relation_type}]-> "
            f"{self.target})"
        )

    ###########################################################################
    # Serialization
    ###########################################################################

    def to_dict(self) -> dict[str, object]:
        """
        Canonical dictionary representation.
        """

        return {
            "source": self.source,
            "target": self.target,
            "relation_type": self.relation_type,
        }

    ###########################################################################
    # String Representation
    ###########################################################################

    def __str__(self) -> str:

        return self.summary()

    def __repr__(self) -> str:

        return (
            "Relation("
            f"source={self.source!r}, "
            f"target={self.target!r}, "
            f"relation_type={self.relation_type!r})"
        )


###############################################################################
# Public API
###############################################################################

__all__ = [
    "Relation",
    "DEFAULT_RELATION_TYPE",
    "MODULE_NAME",
    "OBJECT_NAME",
]