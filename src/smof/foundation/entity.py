from __future__ import annotations

from dataclasses import dataclass
from typing import Final


###############################################################################
# Module Constants
###############################################################################

MODULE_NAME: Final[str] = "smof.foundation.entity"

OBJECT_NAME: Final[str] = "MathematicalEntity"


###############################################################################
# Mathematical Entity
###############################################################################


@dataclass(
    frozen=True,
    slots=True,
)
class MathematicalEntity:
    """
    Immutable Mathematical Entity.

    Mathematical Form

        E ∈ M

    where

        E = Mathematical Entity

        M = Universe of Mathematical Entities

    A MathematicalEntity is the smallest
    identifiable mathematical construct
    within the SMOF Foundation.

    It possesses identity only.

    Higher mathematical theories introduce

        • MathematicalObject
        • MathematicalOperator
        • MathematicalRuntime

    Universal Object Theory later introduces

        • Attributes
        • Relations
        • State
        • Behaviour
    """

    identity: str

    ###########################################################################
    # Validation
    ###########################################################################

    def __post_init__(self) -> None:

        if self.identity is None:
            raise ValueError("identity cannot be None")

        if not isinstance(self.identity, str):
            raise TypeError("identity must be a string")

        if self.identity.strip() == "":
            raise ValueError("identity cannot be empty")

    ###########################################################################
    # Behaviour
    ###########################################################################

    def validate(self) -> bool:
        """
        Construction guarantees validity.
        """

        return True

    def is_valid(self) -> bool:
        """
        Determine whether the MathematicalEntity is valid.
        """

        return self.validate()

    def summary(self) -> str:
        """
        Human-readable summary.
        """

        return f"MathematicalEntity({self.identity})"

    ###########################################################################
    # Serialization
    ###########################################################################

    def to_dict(self) -> dict[str, str]:
        """
        Canonical dictionary representation.
        """

        return {
            "identity": self.identity,
        }

    ###########################################################################
    # String Representation
    ###########################################################################

    def __str__(self) -> str:

        return self.summary()

    def __repr__(self) -> str:

        return (
            "MathematicalEntity("
            f"identity={self.identity!r})"
        )


###############################################################################
# Public API
###############################################################################

__all__ = [
    "MathematicalEntity",
    "MODULE_NAME",
    "OBJECT_NAME",
]