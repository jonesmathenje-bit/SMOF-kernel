from smof.execution_graph import ExecutionGraph, ExecutionNode
from smof.operator import Operator, Constitution


class DummyOperator(Operator):
    def __init__(self):
        super().__init__(
            name='dummy',
            domain=int,
            codomain=int,
            rule=lambda x: x + 1,
            constitution=Constitution()
        )


def test_execution_graph():
    op = DummyOperator()

    node = ExecutionNode(op)
    graph = ExecutionGraph(node)

    assert graph.run(1) == 2
