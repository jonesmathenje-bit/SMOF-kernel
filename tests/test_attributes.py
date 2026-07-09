"""
Unit tests for smof.uot.model.attributes

SVP-0003C
"""

from dataclasses import FrozenInstanceError
from types import MappingProxyType

import pytest

from smof.uot.model.attributes import (
    DEFAULT_VALUES,
    Attributes,
)


def make_attributes() -> Attributes:
    """
    Construct a valid Attributes instance.
    """
    return Attributes(
        values={
            "name": "Universal Object",
            "kind": "Canonical",
            "version": "1.0",
        },
    )


##############################################################################
# Construction
##############################################################################


def test_attributes_creation():
    attributes = make_attributes()

    assert attributes.values["name"] == "Universal Object"
    assert attributes.values["kind"] == "Canonical"
    assert attributes.values["version"] == "1.0"


def test_default_values():
    assert isinstance(DEFAULT_VALUES, MappingProxyType)


##############################################################################
# Immutability
##############################################################################


def test_attributes_is_immutable():
    attributes = make_attributes()

    with pytest.raises(FrozenInstanceError):
        attributes.values = {}


def test_values_mapping_is_read_only():
    attributes = make_attributes()

    with pytest.raises(TypeError):
        attributes.values["new"] = "value"


##############################################################################
# Validation
##############################################################################


def test_none_values():
    with pytest.raises(ValueError):
        Attributes(
            values=None,
        )


##############################################################################
# Methods
##############################################################################


def test_validate_returns_true():
    attributes = make_attributes()

    assert attributes.validate()


def test_is_valid():
    attributes = make_attributes()

    assert attributes.is_valid()


def test_summary():
    attributes = make_attributes()

    assert attributes.summary() == "Attributes(3)"


def test_string_representation():
    attributes = make_attributes()

    assert str(attributes) == attributes.summary()


##############################################################################
# Dictionary Serialization
##############################################################################


def test_to_dict_returns_dictionary():
    attributes = make_attributes()

    assert isinstance(attributes.to_dict(), dict)


def test_to_dict_contains_expected_keys():
    attributes = make_attributes()

    expected = {
        "name",
        "kind",
        "version",
    }

    assert expected.issubset(attributes.to_dict().keys())


def test_to_dict_values():
    attributes = make_attributes()

    data = attributes.to_dict()

    assert data["name"] == "Universal Object"
    assert data["kind"] == "Canonical"
    assert data["version"] == "1.0"


##############################################################################
# Equality
##############################################################################


def test_attributes_equality():
    a = make_attributes()
    b = make_attributes()

    assert a == b


##############################################################################
# Determinism
##############################################################################


def test_to_dict_is_deterministic():
    attributes = make_attributes()

    assert attributes.to_dict() == attributes.to_dict()


def test_summary_is_deterministic():
    attributes = make_attributes()

    assert attributes.summary() == attributes.summary()


def test_validate_is_deterministic():
    attributes = make_attributes()

    assert attributes.validate() == attributes.validate()