"""
Unit tests for smof.uot.model.relation

SVP-0005A
"""

from dataclasses import FrozenInstanceError

import pytest

from smof.uot.model.relation import (
    DEFAULT_RELATION_TYPE,
    Relation,
)


def make_relation() -> Relation:
    """
    Construct a valid Relation instance.
    """
    return Relation(
        source="Object-A",
        target="Object-B",
        relation_type="depends_on",
    )


##############################################################################
# Construction
##############################################################################


def test_relation_creation():
    relation = make_relation()

    assert relation.source == "Object-A"
    assert relation.target == "Object-B"
    assert relation.relation_type == "depends_on"


def test_default_relation_type():
    relation = Relation(
        source="A",
        target="B",
    )

    assert relation.relation_type == DEFAULT_RELATION_TYPE


##############################################################################
# Immutability
##############################################################################


def test_relation_is_immutable():
    relation = make_relation()

    with pytest.raises(FrozenInstanceError):
        relation.source = "Changed"


##############################################################################
# Validation
##############################################################################


def test_empty_source():
    with pytest.raises(ValueError):
        Relation(
            source="",
            target="Object-B",
            relation_type="depends_on",
        )


def test_empty_target():
    with pytest.raises(ValueError):
        Relation(
            source="Object-A",
            target="",
            relation_type="depends_on",
        )


def test_empty_relation_type():
    with pytest.raises(ValueError):
        Relation(
            source="Object-A",
            target="Object-B",
            relation_type="",
        )


##############################################################################
# Methods
##############################################################################


def test_validate_returns_true():
    relation = make_relation()

    assert relation.validate()


def test_is_valid():
    relation = make_relation()

    assert relation.is_valid()


def test_summary():
    relation = make_relation()

    assert (
        relation.summary()
        == "Relation(Object-A -[depends_on]-> Object-B)"
    )


def test_string_representation():
    relation = make_relation()

    assert str(relation) == relation.summary()


##############################################################################
# Dictionary Serialization
##############################################################################


def test_to_dict_returns_dictionary():
    relation = make_relation()

    assert isinstance(relation.to_dict(), dict)


def test_to_dict_contains_expected_keys():
    relation = make_relation()

    expected = {
        "source",
        "target",
        "relation_type",
    }

    assert expected.issubset(relation.to_dict().keys())


def test_to_dict_values():
    relation = make_relation()

    data = relation.to_dict()

    assert data["source"] == "Object-A"
    assert data["target"] == "Object-B"
    assert data["relation_type"] == "depends_on"


##############################################################################
# Equality
##############################################################################


def test_relation_equality():
    a = make_relation()
    b = make_relation()

    assert a == b


##############################################################################
# Determinism
##############################################################################


def test_to_dict_is_deterministic():
    relation = make_relation()

    assert relation.to_dict() == relation.to_dict()


def test_summary_is_deterministic():
    relation = make_relation()

    assert relation.summary() == relation.summary()


def test_validate_is_deterministic():
    relation = make_relation()

    assert relation.validate() == relation.validate()