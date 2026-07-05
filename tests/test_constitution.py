"""
Unit tests for smof.constitution

SVP-0001
"""

from smof.constitution import (
    ARTICLES,
    CONSTITUTION_AUTHORITY,
    CONSTITUTION_NAME,
    CONSTITUTION_STATUS,
    CONSTITUTION_VERSION,
    constitution_info,
)


def test_constitution_name():
    assert CONSTITUTION_NAME == "SMOF Mathematical Constitution"


def test_constitution_version():
    assert CONSTITUTION_VERSION == "1.0"


def test_constitution_authority():
    assert CONSTITUTION_AUTHORITY == "SMOF Reference Mathematical Kernel"


def test_constitution_status():
    assert CONSTITUTION_STATUS == "Active"


def test_articles_is_tuple():
    assert isinstance(ARTICLES, tuple)


def test_constitution_info_returns_dictionary():
    assert isinstance(constitution_info(), dict)


def test_constitution_info_contains_expected_keys():
    info = constitution_info()

    expected = {
        "name",
        "version",
        "authority",
        "status",
        "articles",
    }

    assert expected.issubset(info.keys())


def test_constitution_info_is_deterministic():
    assert constitution_info() == constitution_info()
