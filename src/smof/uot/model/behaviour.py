from __future__ import annotations

from dataclasses import dataclass
from typing import Final


###############################################################################
# Module Constants
###############################################################################

DEFAULT_DESCRIPTION: Final[str] = ""

MODULE_NAME: Final[str] = "smof.uot.model.behaviour"

OBJECT_NAME: Final[str] = "Behaviour"


###############################################################################
# Behaviour
###############################################################################


@dataclass(
    frozen=True,
    slots=True,
)
class Behaviour:
    """
    Immutable Behaviour.

    Mathematical Form

        B = (n, d)

    where

        n = behaviour name
        d = behaviour description

    Behaviour represents a deterministic operator that transforms one
    valid state into another while preserving the SMOF Constitution.

    Behaviour itself is immutable.
    """

    name: str

    description: str = DEFAULT_DESCRIPTION

    ###########################################################################
    # Validation
    ###########################################################################

    def __post_init__(self) -> None:

        if not self.name.strip():
            raise ValueError("name cannot be empty")

        if self.description is None:
            raise ValueError("description cannot be None")

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
        Determine whether the Behaviour object is valid.
        """

        return self.validate()

    def summary(self) -> str:
        """
        Human-readable summary.
        """

        return f"Behaviour({self.name})"

    ###########################################################################
    # Serialization
    ###########################################################################

    def to_dict(self) -> dict[str, object]:
        """
        Canonical dictionary representation.
        """

        return {
            "name": self.name,
            "description": self.description,
        }

    ###########################################################################
    # String Representation
    ###########################################################################

    def __str__(self) -> str:

        return self.summary()

    def __repr__(self) -> str:

        return (
            "Behaviour("
            f"name={self.name!r}, "
            f"description={self.description!r})"
        )


###############################################################################
# Public API
###############################################################################

__all__ = [
    "Behaviour",
    "DEFAULT_DESCRIPTION",
    "MODULE_NAME",
    "OBJECT_NAME",
]