"""
Unit tests for smof.definition

SVP-0003
"""

from dataclasses import FrozenInstanceError

import pytest

from smof.definition import (
    DEFAULT_REVISION,
    Definition,
    DefinitionStatus,
)


def make_definition() -> Definition:
    """
    Construct a valid Definition instance.
    """
    return Definition(
        identifier="Definition-I",
        number=1,
        term="Mathematical Specification",
        statement="Mathematics defines software semantics.",
        formal_definition=(
            "A mathematical specification is a formal "
            "description of software behaviour."
        ),
    )


##############################################################################
# Construction
##############################################################################


def test_definition_creation():
    definition = make_definition()

    assert definition.identifier == "Definition-I"
    assert definition.number == 1
    assert definition.term == "Mathematical Specification"


def test_default_revision():
    definition = make_definition()

    assert definition.revision == DEFAULT_REVISION


def test_default_status():
    definition = make_definition()

    assert definition.status == DefinitionStatus.ACTIVE


##############################################################################
# Immutability
##############################################################################


def test_definition_is_immutable():
    definition = make_definition()

    with pytest.raises(FrozenInstanceError):
        definition.term = "Changed"


##############################################################################
# Validation
##############################################################################


def test_empty_identifier():
    with pytest.raises(ValueError):
        Definition(
            identifier="",
            number=1,
            term="Term",
            statement="Statement",
            formal_definition="Formal Definition",
        )


def test_invalid_number():
    with pytest.raises(ValueError):
        Definition(
            identifier="Definition-I",
            number=0,
            term="Term",
            statement="Statement",
            formal_definition="Formal Definition",
        )


def test_empty_term():
    with pytest.raises(ValueError):
        Definition(
            identifier="Definition-I",
            number=1,
            term="",
            statement="Statement",
            formal_definition="Formal Definition",
        )


def test_empty_statement():
    with pytest.raises(ValueError):
        Definition(
            identifier="Definition-I",
            number=1,
            term="Term",
            statement="",
            formal_definition="Formal Definition",
        )


def test_empty_formal_definition():
    with pytest.raises(ValueError):
        Definition(
            identifier="Definition-I",
            number=1,
            term="Term",
            statement="Statement",
            formal_definition="",
        )


def test_empty_revision():
    with pytest.raises(ValueError):
        Definition(
            identifier="Definition-I",
            number=1,
            term="Term",
            statement="Statement",
            formal_definition="Formal Definition",
            revision="",
        )


##############################################################################
# Methods
##############################################################################


def test_is_active():
    definition = make_definition()

    assert definition.is_active()


def test_summary():
    definition = make_definition()

    assert (
        definition.summary()
        == "Definition-I: Mathematical Specification"
    )


def test_validate_returns_true():
    definition = make_definition()

    assert definition.validate()


def test_string_representation():
    definition = make_definition()

    assert str(definition) == definition.summary()


##############################################################################
# Dictionary Serialization
##############################################################################


def test_to_dict_returns_dictionary():
    definition = make_definition()

    assert isinstance(definition.to_dict(), dict)


def test_to_dict_contains_expected_keys():
    definition = make_definition()

    expected = {
        "identifier",
        "number",
        "term",
        "statement",
        "formal_definition",
        "revision",
        "status",
    }

    assert expected.issubset(definition.to_dict().keys())


def test_status_serialized_as_string():
    definition = make_definition()

    assert definition.to_dict()["status"] == "Active"


##############################################################################
# Equality / Hashing
##############################################################################


def test_definition_equality():
    a = make_definition()
    b = make_definition()

    assert a == b


def test_definition_hash():
    a = make_definition()
    b = make_definition()

    assert hash(a) == hash(b)


##############################################################################
# Determinism
##############################################################################


def test_to_dict_is_deterministic():
    definition = make_definition()

    assert definition.to_dict() == definition.to_dict()


def test_summary_is_deterministic():
    definition = make_definition()

    assert definition.summary() == definition.summary()


def test_validate_is_deterministic():
    definition = make_definition()

    assert definition.validate() == definition.validate()


##############################################################################
# Status
##############################################################################


def test_draft_status():
    definition = Definition(
        identifier="Definition-X",
        number=10,
        term="Draft",
        statement="Draft Definition",
        formal_definition="Draft Formal Definition",
        status=DefinitionStatus.DRAFT,
    )

    assert not definition.is_active()


def test_deprecated_status():
    definition = Definition(
        identifier="Definition-X",
        number=10,
        term="Deprecated",
        statement="Deprecated Definition",
        formal_definition="Deprecated Formal Definition",
        status=DefinitionStatus.DEPRECATED,
    )

    assert not definition.is_active()


def test_superseded_status():
    definition = Definition(
        identifier="Definition-X",
        number=10,
        term="Superseded",
        statement="Superseded Definition",
        formal_definition="Superseded Formal Definition",
        status=DefinitionStatus.SUPERSEDED,
    )

    assert not definition.is_active()