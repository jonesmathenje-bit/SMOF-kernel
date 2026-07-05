from smof.execution_graph import ExecutionNode, ExecutionGraph
from smof.operator import Operator


class GraphBuilder:
    def __init__(self):
        self.nodes = []

    def node(self, operator: Operator) -> ExecutionNode:
        n = ExecutionNode(operator)
        self.nodes.append(n)
        return n

    def connect(self, a: ExecutionNode, b: ExecutionNode):
        a.connect(b)

    def build(self, root: ExecutionNode) -> ExecutionGraph:
        return ExecutionGraph(root)
