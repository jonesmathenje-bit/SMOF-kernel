"""
Unit tests for smof.uot.model.identity

SVP-0003B
"""

from dataclasses import FrozenInstanceError

import pytest

from smof.uot.model.identity import (
    DEFAULT_NAMESPACE,
    DEFAULT_VERSION,
    Identity,
)


def make_identity() -> Identity:
    """
    Construct a valid Identity instance.
    """
    return Identity(
        identifier="Object-I",
    )


##############################################################################
# Construction
##############################################################################


def test_identity_creation():
    identity = make_identity()

    assert identity.identifier == "Object-I"


def test_default_namespace():
    identity = make_identity()

    assert identity.namespace == DEFAULT_NAMESPACE


def test_default_version():
    identity = make_identity()

    assert identity.version == DEFAULT_VERSION


##############################################################################
# Immutability
##############################################################################


def test_identity_is_immutable():
    identity = make_identity()

    with pytest.raises(FrozenInstanceError):
        identity.identifier = "Changed"


##############################################################################
# Validation
##############################################################################


def test_empty_identifier():
    with pytest.raises(ValueError):
        Identity(
            identifier="",
        )


def test_empty_namespace():
    with pytest.raises(ValueError):
        Identity(
            identifier="Object-I",
            namespace="",
        )


def test_empty_version():
    with pytest.raises(ValueError):
        Identity(
            identifier="Object-I",
            version="",
        )


##############################################################################
# Methods
##############################################################################


def test_validate_returns_true():
    identity = make_identity()

    assert identity.validate()


def test_is_valid():
    identity = make_identity()

    assert identity.is_valid()


def test_summary():
    identity = make_identity()

    assert identity.summary() == "Identity(Object-I)"


def test_string_representation():
    identity = make_identity()

    assert str(identity) == identity.summary()


##############################################################################
# Dictionary Serialization
##############################################################################


def test_to_dict_returns_dictionary():
    identity = make_identity()

    assert isinstance(identity.to_dict(), dict)


def test_to_dict_contains_expected_keys():
    identity = make_identity()

    expected = {
        "identifier",
        "namespace",
        "version",
    }

    assert expected.issubset(identity.to_dict().keys())


def test_to_dict_values():
    identity = make_identity()

    data = identity.to_dict()

    assert data["identifier"] == "Object-I"
    assert data["namespace"] == DEFAULT_NAMESPACE
    assert data["version"] == DEFAULT_VERSION


##############################################################################
# Equality
##############################################################################


def test_identity_equality():
    a = make_identity()
    b = make_identity()

    assert a == b


##############################################################################
# Determinism
##############################################################################


def test_to_dict_is_deterministic():
    identity = make_identity()

    assert identity.to_dict() == identity.to_dict()


def test_summary_is_deterministic():
    identity = make_identity()

    assert identity.summary() == identity.summary()


def test_validate_is_deterministic():
    identity = make_identity()

    assert identity.validate() == identity.validate()