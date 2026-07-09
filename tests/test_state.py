"""
Unit tests for smof.uot.model.state

SVP-0006A
"""

from collections.abc import Mapping
from dataclasses import FrozenInstanceError

import pytest

from smof.uot.model.state import (
    DEFAULT_VALUES,
    State,
)


def make_state() -> State:
    """
    Construct a valid State instance.
    """
    return State(
        values={
            "status": "Active",
            "revision": "1.0",
        },
    )


##############################################################################
# Construction
##############################################################################


def test_state_creation():
    state = make_state()

    assert state.values["status"] == "Active"
    assert state.values["revision"] == "1.0"


def test_default_values():
    assert isinstance(DEFAULT_VALUES, Mapping)


##############################################################################
# Immutability
##############################################################################


def test_state_is_immutable():
    state = make_state()

    with pytest.raises(FrozenInstanceError):
        state.values = {}


def test_values_mapping_is_read_only():
    state = make_state()

    with pytest.raises(TypeError):
        state.values["status"] = "Inactive"


##############################################################################
# Validation
##############################################################################


def test_none_values():
    with pytest.raises(ValueError):
        State(
            values=None,
        )


##############################################################################
# Methods
##############################################################################


def test_validate_returns_true():
    state = make_state()

    assert state.validate()


def test_is_valid():
    state = make_state()

    assert state.is_valid()


def test_summary():
    state = make_state()

    assert state.summary() == "State(2)"


def test_string_representation():
    state = make_state()

    assert str(state) == state.summary()


##############################################################################
# Dictionary Serialization
##############################################################################


def test_to_dict_returns_dictionary():
    state = make_state()

    assert isinstance(state.to_dict(), dict)


def test_to_dict_contains_expected_keys():
    state = make_state()

    expected = {
        "status",
        "revision",
    }

    assert expected.issubset(state.to_dict().keys())


def test_to_dict_values():
    state = make_state()

    data = state.to_dict()

    assert data["status"] == "Active"
    assert data["revision"] == "1.0"


##############################################################################
# Equality
##############################################################################


def test_state_equality():
    a = make_state()
    b = make_state()

    assert a == b


##############################################################################
# Determinism
##############################################################################


def test_to_dict_is_deterministic():
    state = make_state()

    assert state.to_dict() == state.to_dict()


def test_summary_is_deterministic():
    state = make_state()

    assert state.summary() == state.summary()


def test_validate_is_deterministic():
    state = make_state()

    assert state.validate() == state.validate()