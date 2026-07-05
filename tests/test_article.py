"""
Unit tests for smof.article

SVP-0002
"""

from dataclasses import FrozenInstanceError

import pytest

from smof.article import (
    DEFAULT_REVISION,
    Article,
    ArticleStatus,
)


def make_article() -> Article:
    """
    Construct a valid Article instance.
    """
    return Article(
        identifier="Article-I",
        number=1,
        title="Mathematics is the Specification",
        text="Mathematics defines the specification of every SMOF object.",
    )


##############################################################################
# Construction
##############################################################################


def test_article_creation():
    article = make_article()

    assert article.identifier == "Article-I"
    assert article.number == 1
    assert article.title == "Mathematics is the Specification"


def test_default_revision():
    article = make_article()

    assert article.revision == DEFAULT_REVISION


def test_default_status():
    article = make_article()

    assert article.status == ArticleStatus.ACTIVE


##############################################################################
# Immutability
##############################################################################


def test_article_is_immutable():
    article = make_article()

    with pytest.raises(FrozenInstanceError):
        article.title = "Changed"


##############################################################################
# Validation
##############################################################################


def test_empty_identifier():
    with pytest.raises(ValueError):
        Article(
            identifier="",
            number=1,
            title="Title",
            text="Body",
        )


def test_invalid_number():
    with pytest.raises(ValueError):
        Article(
            identifier="Article-I",
            number=0,
            title="Title",
            text="Body",
        )


def test_empty_title():
    with pytest.raises(ValueError):
        Article(
            identifier="Article-I",
            number=1,
            title="",
            text="Body",
        )


def test_empty_text():
    with pytest.raises(ValueError):
        Article(
            identifier="Article-I",
            number=1,
            title="Title",
            text="",
        )


def test_empty_revision():
    with pytest.raises(ValueError):
        Article(
            identifier="Article-I",
            number=1,
            title="Title",
            text="Body",
            revision="",
        )


##############################################################################
# Methods
##############################################################################


def test_is_active():
    article = make_article()

    assert article.is_active()


def test_summary():
    article = make_article()

    assert article.summary() == (
        "Article-I: Mathematics is the Specification"
    )


def test_validate_returns_true():
    article = make_article()

    assert article.validate()


def test_string_representation():
    article = make_article()

    assert str(article) == article.summary()


##############################################################################
# Dictionary Serialization
##############################################################################


def test_to_dict_returns_dictionary():
    article = make_article()

    assert isinstance(article.to_dict(), dict)


def test_to_dict_contains_expected_keys():
    article = make_article()

    expected = {
        "identifier",
        "number",
        "title",
        "text",
        "revision",
        "status",
    }

    assert expected.issubset(article.to_dict().keys())


def test_status_serialized_as_string():
    article = make_article()

    assert article.to_dict()["status"] == "Active"


##############################################################################
# Equality / Hashing
##############################################################################


def test_article_equality():
    a = make_article()
    b = make_article()

    assert a == b


def test_article_hash():
    a = make_article()
    b = make_article()

    assert hash(a) == hash(b)


##############################################################################
# Determinism
##############################################################################


def test_to_dict_is_deterministic():
    article = make_article()

    assert article.to_dict() == article.to_dict()


def test_summary_is_deterministic():
    article = make_article()

    assert article.summary() == article.summary()


def test_validate_is_deterministic():
    article = make_article()

    assert article.validate() == article.validate()


##############################################################################
# Status
##############################################################################


def test_draft_status():
    article = Article(
        identifier="Article-X",
        number=10,
        title="Draft",
        text="Draft article",
        status=ArticleStatus.DRAFT,
    )

    assert not article.is_active()


def test_deprecated_status():
    article = Article(
        identifier="Article-X",
        number=10,
        title="Deprecated",
        text="Deprecated article",
        status=ArticleStatus.DEPRECATED,
    )

    assert not article.is_active()


def test_superseded_status():
    article = Article(
        identifier="Article-X",
        number=10,
        title="Superseded",
        text="Superseded article",
        status=ArticleStatus.SUPERSEDED,
    )

    assert not article.is_active()
