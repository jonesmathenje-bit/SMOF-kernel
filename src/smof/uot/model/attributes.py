from __future__ import annotations

from dataclasses import dataclass, field
from types import MappingProxyType
from typing import Final
from typing import Mapping


###############################################################################
# Module Constants
###############################################################################

DEFAULT_VALUES: Final[Mapping[str, object]] = MappingProxyType({})

MODULE_NAME: Final[str] = "smof.uot.model.attributes"

OBJECT_NAME: Final[str] = "Attributes"


###############################################################################
# Attributes
###############################################################################


@dataclass(
    frozen=True,
    slots=True,
)
class Attributes:
    """
    Immutable Attributes.

    Mathematical Form

        A = {(k₁,v₁), (k₂,v₂), … , (kₙ,vₙ)}

    where

        k = attribute name
        v = attribute value

    Attributes are immutable and deterministic.
    """

    values: Mapping[str, object] = field(
    default_factory=lambda: MappingProxyType({})
)

    ###########################################################################
    # Validation
    ###########################################################################

    def __post_init__(self) -> None:

        if self.values is None:
            raise ValueError("values cannot be None")

        object.__setattr__(
            self,
            "values",
            MappingProxyType(dict(self.values)),
        )

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
        Determine whether the Attributes object is valid.
        """

        return self.validate()

    def summary(self) -> str:
        """
        Human-readable summary.
        """

        return f"Attributes({len(self.values)})"

    ###########################################################################
    # Serialization
    ###########################################################################

    def to_dict(self) -> dict[str, object]:
        """
        Canonical dictionary representation.
        """

        return dict(self.values)

    ###########################################################################
    # String Representation
    ###########################################################################

    def __str__(self) -> str:

        return self.summary()

    def __repr__(self) -> str:

        return (
            "Attributes("
            f"values={dict(self.values)!r})"
        )


###############################################################################
# Public API
###############################################################################

__all__ = [
    "Attributes",
    "DEFAULT_VALUES",
    "MODULE_NAME",
    "OBJECT_NAME",
]