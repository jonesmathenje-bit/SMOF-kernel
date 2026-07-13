from __future__ import annotations

from dataclasses import FrozenInstanceError

import pytest

from smof.foundation.entity import MathematicalEntity


###############################################################################
# Construction
###############################################################################


def test_entity_creation() -> None:

    entity = MathematicalEntity("ENTITY-001")

    assert entity.identity == "ENTITY-001"


###############################################################################
# Validation
###############################################################################


def test_none_identity() -> None:

    with pytest.raises(ValueError):

        MathematicalEntity(None)  # type: ignore[arg-type]


def test_empty_identity() -> None:

    with pytest.raises(ValueError):

        MathematicalEntity("")


def test_whitespace_identity() -> None:

    with pytest.raises(ValueError):

        MathematicalEntity("     ")


###############################################################################
# Immutability
###############################################################################


def test_entity_is_immutable() -> None:

    entity = MathematicalEntity("ENTITY")

    with pytest.raises(FrozenInstanceError):

        entity.identity = "NEW"


###############################################################################
# Behaviour
###############################################################################


def test_validate_returns_true() -> None:

    entity = MathematicalEntity("ENTITY")

    assert entity.validate() is True


def test_is_valid() -> None:

    entity = MathematicalEntity("ENTITY")

    assert entity.is_valid() is True


def test_summary() -> None:

    entity = MathematicalEntity("ENTITY")

    assert entity.summary() == "MathematicalEntity(ENTITY)"


###############################################################################
# Serialization
###############################################################################


def test_to_dict_returns_dictionary() -> None:

    entity = MathematicalEntity("ENTITY")

    assert isinstance(entity.to_dict(), dict)


def test_to_dict_contains_identity() -> None:

    entity = MathematicalEntity("ENTITY")

    assert entity.to_dict()["identity"] == "ENTITY"


###############################################################################
# Representation
###############################################################################


def test_string_representation() -> None:

    entity = MathematicalEntity("ENTITY")

    assert str(entity) == entity.summary()


def test_repr_contains_class_name() -> None:

    entity = MathematicalEntity("ENTITY")

    assert "MathematicalEntity" in repr(entity)


###############################################################################
# Equality
###############################################################################


def test_entity_equality() -> None:

    left = MathematicalEntity("ENTITY")

    right = MathematicalEntity("ENTITY")

    assert left == right


###############################################################################
# Determinism
###############################################################################


def test_summary_is_deterministic() -> None:

    entity = MathematicalEntity("ENTITY")

    assert entity.summary() == entity.summary()


def test_to_dict_is_deterministic() -> None:

    entity = MathematicalEntity("ENTITY")

    assert entity.to_dict() == entity.to_dict()


def test_validate_is_deterministic() -> None:

    entity = MathematicalEntity("ENTITY")

    assert entity.validate() == entity.validate()