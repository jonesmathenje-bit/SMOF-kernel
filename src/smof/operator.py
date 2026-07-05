from abc import ABC, abstractmethod
from typing import Any, Callable


class ConstitutionError(Exception):
    pass


class Constitution:
    """
    SEP-0001 placeholder hook
    Replace with real constitution logic
    """
    def validate(self, obj: Any) -> bool:
        return True


class Operator(ABC):

    def __init__(self, name: str, domain: type, codomain: type, rule: Callable, constitution: Constitution):
        self.name = name
        self.domain = domain
        self.codomain = codomain
        self.rule = rule
        self.constitution = constitution

    def __call__(self, x: Any) -> Any:
        return self.execute(x)

    def execute(self, x: Any) -> Any:
        self._validate_input(x)
        result = self.rule(x)
        self._validate_output(result)
        return result

    def _validate_input(self, x: Any):
        if not isinstance(x, self.domain):
            raise TypeError(f"{self.name}: invalid input type")

        if not self.constitution.validate(x):
            raise ConstitutionError(f"{self.name}: input violates constitution")

    def _validate_output(self, y: Any):
        if not isinstance(y, self.codomain):
            raise TypeError(f"{self.name}: invalid output type")

        if not self.constitution.validate(y):
            raise ConstitutionError(f"{self.name}: output violates constitution")


class CompositeOperator(Operator):

    def __init__(self, name: str, op1: Operator, op2: Operator):
        self.op1 = op1
        self.op2 = op2

        super().__init__(
            name=name,
            domain=op1.domain,
            codomain=op2.codomain,
            rule=self._compose,
            constitution=op1.constitution
        )

    def _compose(self, x: Any) -> Any:
        return self.op2(self.op1(x))
