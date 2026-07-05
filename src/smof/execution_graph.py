from typing import Any, List
from smof.operator import Operator, ConstitutionError


class ExecutionNode:
    def __init__(self, operator: Operator):
        self.operator = operator
        self.outputs: List["ExecutionNode"] = []

    def connect(self, node: "ExecutionNode"):
        self.outputs.append(node)


class ExecutionGraph:
    def __init__(self, root: ExecutionNode):
        self.root = root

    def run(self, input_data: Any) -> Any:
        visited = set()

        def _execute(node: ExecutionNode, data: Any) -> Any:
            if id(node) in visited:
                return data

            visited.add(id(node))

            try:
                result = node.operator(data)
            except ConstitutionError as e:
                raise RuntimeError(f"Graph halted: {e}")

            if not node.outputs:
                return result

            current = result
            for child in node.outputs:
                current = _execute(child, current)

            return current

        return _execute(self.root, input_data)
