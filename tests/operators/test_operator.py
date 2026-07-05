import pytest
from smof.operator import Operator, Constitution


class DummyOperator(Operator):
    def __init__(self):
        super().__init__(
            name="dummy",
            domain=int,
            codomain=int,
            rule=lambda x: x + 1,
            constitution=Constitution()
        )


def test_operator_execution():
    op = DummyOperator()
    assert op(1) == 2
    assert op.execute(5) == 6
