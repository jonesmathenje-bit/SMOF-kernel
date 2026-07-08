"""
Unit tests for smof.uot.model.universal_object

SVP-0003A
"""

from collections.abc import Mapping
from dataclasses import FrozenInstanceError

import pytest

from smof.uot.model.universal_object import (
    DEFAULT_ATTRIBUTES,
    DEFAULT_RELATIONS,
    DEFAULT_STATE,
    UniversalObject,
)


def make_universal_object() -> UniversalObject:
    """
    Construct a valid UniversalObject instance.
    """
    return UniversalObject(
        identity="Object-I",
        attributes={
            "name": "Universal Object",
            "kind": "Canonical",
        },
        relations=(
            "Relation-A",
            "Relation-B",
        ),
        state={
            "status": "Active",
            "revision": "1.0",
        },
    )


##############################################################################
# Construction
##############################################################################


def test_universal_object_creation():
    obj = make_universal_object()

    assert obj.identity == "Object-I"
    assert obj.attributes["name"] == "Universal Object"
    assert obj.relations == (
        "Relation-A",
        "Relation-B",
    )
    assert obj.state["status"] == "Active"


def test_default_attributes():
    assert isinstance(DEFAULT_ATTRIBUTES, Mapping)


def test_default_relations():
    assert DEFAULT_RELATIONS == ()


def test_default_state():
     assert isinstance(DEFAULT_STATE, Mapping)


##############################################################################
# Immutability
##############################################################################


def test_universal_object_is_immutable():
    obj = make_universal_object()

    with pytest.raises(FrozenInstanceError):
        obj.identity = "Changed"


##############################################################################
# Validation
##############################################################################


def test_empty_identity():
    with pytest.raises(ValueError):
        UniversalObject(
            identity="",
            attributes={},
            relations=(),
            state={},
        )


def test_none_attributes():
    with pytest.raises(ValueError):
        UniversalObject(
            identity="Object-I",
            attributes=None,
            relations=(),
            state={},
        )


def test_none_relations():
    with pytest.raises(ValueError):
        UniversalObject(
            identity="Object-I",
            attributes={},
            relations=None,
            state={},
        )


def test_none_state():
    with pytest.raises(ValueError):
        UniversalObject(
            identity="Object-I",
            attributes={},
            relations=(),
            state=None,
        )


##############################################################################
# Methods
##############################################################################


def test_validate_returns_true():
    obj = make_universal_object()

    assert obj.validate()


def test_is_valid():
    obj = make_universal_object()

    assert obj.is_valid()


def test_summary():
    obj = make_universal_object()

    assert obj.summary() == "UniversalObject(Object-I)"


def test_string_representation():
    obj = make_universal_object()

    assert str(obj) == obj.summary()


##############################################################################
# Dictionary Serialization
##############################################################################


def test_to_dict_returns_dictionary():
    obj = make_universal_object()

    assert isinstance(obj.to_dict(), dict)


def test_to_dict_contains_expected_keys():
    obj = make_universal_object()

    expected = {
        "identity",
        "attributes",
        "relations",
        "state",
    }

    assert expected.issubset(obj.to_dict().keys())


##############################################################################
# Determinism
##############################################################################


def test_to_dict_is_deterministic():
    obj = make_universal_object()

    assert obj.to_dict() == obj.to_dict()


def test_summary_is_deterministic():
    obj = make_universal_object()

    assert obj.summary() == obj.summary()


def test_validate_is_deterministic():
    obj = make_universal_object()

    assert obj.validate() == obj.validate()