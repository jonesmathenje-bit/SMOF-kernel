from smof.operator import Operator
from smof.article import Article


class CreateArticleOperator(Operator):

    def __init__(self, constitution):
        super().__init__(
            name="create_article",
            domain=dict,
            codomain=Article,
            rule=self._create,
            constitution=constitution
        )

    def _create(self, data: dict) -> Article:
        return Article(
            identifier=data.get("id"),
            content=data.get("content", ""),
            metadata=data.get("metadata", {})
        )
