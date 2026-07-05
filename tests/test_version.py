"""
Unit tests for smof.version

SVP-0000B
"""

from smof.version import (
    API_VERSION,
    BUILD_METADATA,
    KERNEL_NAME,
    RELEASE_STAGE,
    VERSION,
    __version__,
    version_info,
)


def test_kernel_name():
    assert KERNEL_NAME == "SMOF Reference Mathematical Kernel"


def test_version_tuple():
    assert VERSION == (0, 1, 0)


def test_version_string():
    assert __version__ == "0.1.0-alpha.1"


def test_api_version():
    assert API_VERSION == "0.1"


def test_release_stage():
    assert RELEASE_STAGE == "alpha"


def test_build_metadata():
    assert BUILD_METADATA == "1"


def test_version_info_returns_dictionary():
    info = version_info()

    assert isinstance(info, dict)


def test_version_info_contains_expected_keys():
    info = version_info()

    expected = {
        "kernel",
        "major",
        "minor",
        "patch",
        "version",
        "version_tuple",
        "api_version",
        "release_stage",
        "build_metadata",
    }

    assert expected.issubset(info.keys())


def test_version_info_is_deterministic():
    assert version_info() == version_info()


def test_version_tuple_matches_string():
    major, minor, patch = VERSION

    assert __version__.startswith(f"{major}.{minor}.{patch}")
