from __future__ import annotations

from types import MappingProxyType
from dataclasses import dataclass
from typing import Final
from typing import Mapping


###############################################################################
# Universal Object
###############################################################################


@dataclass(
    frozen=True,
    slots=True,
)
class UniversalObject:
    """
    Immutable Universal Object.

    Every canonical SMOF object is a realization of

        O = (I, A, R, S)

    where

        I = Identity
        A = Attributes
        R = Relations
        S = State
    """

    identity: str

    attributes: Mapping[str, object]

    relations: tuple[str, ...]

    state: Mapping[str, object]

    ###########################################################################
    # Validation
    ###########################################################################

    def __post_init__(self) -> None:

        if not self.identity.strip():
            raise ValueError("identity cannot be empty")

        if self.attributes is None:
            raise ValueError("attributes cannot be None")

        if self.relations is None:
            raise ValueError("relations cannot be None")

        if self.state is None:
            raise ValueError("state cannot be None")

        # Freeze mutable mappings
        object.__setattr__(
            self,
            "attributes",
            MappingProxyType(dict(self.attributes)),
        )

        object.__setattr__(
            self,
            "state",
            MappingProxyType(dict(self.state)),
        )

    ###########################################################################
    # Behaviour
    ###########################################################################

    def validate(self) -> bool:
        """
        Validate the Universal Object.

        Construction guarantees validity.

        Therefore this function is deterministic.
        """

        return True

    def is_valid(self) -> bool:
        """
        Determine whether the object is valid.
        """

        return self.validate()

    def summary(self) -> str:
        """
        Human-readable summary.
        """

        return f"UniversalObject({self.identity})"

    ###########################################################################
    # Serialization
    ###########################################################################

    def to_dict(self) -> dict[str, object]:
        """
        Canonical dictionary representation.
        """

        return {
            "identity": self.identity,
            "attributes": dict(self.attributes),
            "relations": self.relations,
            "state": dict(self.state),
        }

    ###########################################################################
    # String Representation
    ###########################################################################

    def __str__(self) -> str:
        return self.summary()

    def __repr__(self) -> str:

        return (
            "UniversalObject("
            f"identity={self.identity!r}, "
            f"attributes={dict(self.attributes)!r}, "
            f"relations={self.relations!r}, "
            f"state={dict(self.state)!r})"
        )


###############################################################################
# Module Constants
###############################################################################

DEFAULT_ATTRIBUTES: Final[Mapping[str, object]] = MappingProxyType({})

DEFAULT_RELATIONS: Final[tuple[str, ...]] = ()

DEFAULT_STATE: Final[Mapping[str, object]] = MappingProxyType({})

MODULE_NAME: Final[str] = "smof.uot.model.universal_object"

OBJECT_NAME: Final[str] = "UniversalObject"


###############################################################################
# Public API
###############################################################################

__all__ = [
    "UniversalObject",
    "DEFAULT_ATTRIBUTES",
    "DEFAULT_RELATIONS",
    "DEFAULT_STATE",
    "MODULE_NAME",
    "OBJECT_NAME",
]