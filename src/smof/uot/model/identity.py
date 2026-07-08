from __future__ import annotations

from dataclasses import dataclass
from typing import Final


###############################################################################
# Module Constants
###############################################################################

DEFAULT_NAMESPACE: Final[str] = "smof"

DEFAULT_VERSION: Final[str] = "1.0"

MODULE_NAME: Final[str] = "smof.uot.model.identity"

OBJECT_NAME: Final[str] = "Identity"


###############################################################################
# Identity
###############################################################################


@dataclass(
    frozen=True,
    slots=True,
)
class Identity:
    """
    Immutable Identity.

    Mathematical Form

        I = (ι, N, V)

    where

        ι = identifier
        N = namespace
        V = version

    Identity is the canonical representation of uniqueness
    within the SMOF Universal Object Theory.
    """

    identifier: str

    namespace: str = DEFAULT_NAMESPACE

    version: str = DEFAULT_VERSION

    ###########################################################################
    # Validation
    ###########################################################################

    def __post_init__(self) -> None:

        if not self.identifier.strip():
            raise ValueError("identifier cannot be empty")

        if not self.namespace.strip():
            raise ValueError("namespace cannot be empty")

        if not self.version.strip():
            raise ValueError("version cannot be empty")

    ###########################################################################
    # Behaviour
    ###########################################################################

    def validate(self) -> bool:
        """
        Validate the Identity.

        Construction guarantees validity.

        Therefore this function is deterministic.
        """

        return True

    def is_valid(self) -> bool:
        """
        Determine whether this Identity is valid.
        """

        return self.validate()

    def summary(self) -> str:
        """
        Human-readable summary.
        """

        return f"Identity({self.identifier})"

    ###########################################################################
    # Serialization
    ###########################################################################

    def to_dict(self) -> dict[str, str]:
        """
        Canonical dictionary representation.
        """

        return {
            "identifier": self.identifier,
            "namespace": self.namespace,
            "version": self.version,
        }

    ###########################################################################
    # String Representation
    ###########################################################################

    def __str__(self) -> str:

        return self.summary()

    def __repr__(self) -> str:

        return (
            "Identity("
            f"identifier={self.identifier!r}, "
            f"namespace={self.namespace!r}, "
            f"version={self.version!r})"
        )


###############################################################################
# Public API
###############################################################################

__all__ = [
    "Identity",
    "DEFAULT_NAMESPACE",
    "DEFAULT_VERSION",
    "MODULE_NAME",
    "OBJECT_NAME",
]