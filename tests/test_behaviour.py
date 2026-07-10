"""
Unit tests for smof.uot.model.behaviour

SVP-0007A
"""

from dataclasses import FrozenInstanceError

import pytest

from smof.uot.model.behaviour import (
    DEFAULT_DESCRIPTION,
    Behaviour,
)


def make_behaviour() -> Behaviour:
    """
    Construct a valid Behaviour instance.
    """
    return Behaviour(
        name="Publish",
        description="Publish a document.",
    )


##############################################################################
# Construction
##############################################################################


def test_behaviour_creation():
    behaviour = make_behaviour()

    assert behaviour.name == "Publish"
    assert behaviour.description == "Publish a document."


def test_default_description():
    behaviour = Behaviour(
        name="Activate",
    )

    assert behaviour.description == DEFAULT_DESCRIPTION


##############################################################################
# Immutability
##############################################################################


def test_behaviour_is_immutable():
    behaviour = make_behaviour()

    with pytest.raises(FrozenInstanceError):
        behaviour.name = "Deactivate"


##############################################################################
# Validation
##############################################################################


def test_empty_name():
    with pytest.raises(ValueError):
        Behaviour(
            name="",
            description="Test",
        )


def test_none_description():
    with pytest.raises(ValueError):
        Behaviour(
            name="Publish",
            description=None,
        )


##############################################################################
# Methods
##############################################################################


def test_validate_returns_true():
    behaviour = make_behaviour()

    assert behaviour.validate()


def test_is_valid():
    behaviour = make_behaviour()

    assert behaviour.is_valid()


def test_summary():
    behaviour = make_behaviour()

    assert behaviour.summary() == "Behaviour(Publish)"


def test_string_representation():
    behaviour = make_behaviour()

    assert str(behaviour) == behaviour.summary()


##############################################################################
# Dictionary Serialization
##############################################################################


def test_to_dict_returns_dictionary():
    behaviour = make_behaviour()

    assert isinstance(behaviour.to_dict(), dict)


def test_to_dict_contains_expected_keys():
    behaviour = make_behaviour()

    expected = {
        "name",
        "description",
    }

    assert expected.issubset(behaviour.to_dict().keys())


def test_to_dict_values():
    behaviour = make_behaviour()

    data = behaviour.to_dict()

    assert data["name"] == "Publish"
    assert data["description"] == "Publish a document."


##############################################################################
# Equality
##############################################################################


def test_behaviour_equality():
    a = make_behaviour()
    b = make_behaviour()

    assert a == b


##############################################################################
# Determinism
##############################################################################


def test_to_dict_is_deterministic():
    behaviour = make_behaviour()

    assert behaviour.to_dict() == behaviour.to_dict()


def test_summary_is_deterministic():
    behaviour = make_behaviour()

    assert behaviour.summary() == behaviour.summary()


def test_validate_is_deterministic():
    behaviour = make_behaviour()

    assert behaviour.validate() == behaviour.validate()