import argparse
from smof.graph_builder import GraphBuilder
from smof.operators.article_ops import CreateArticleOperator
from smof.operator import Constitution


def main():
    parser = argparse.ArgumentParser(description='SMOF Execution Graph CLI')
    parser.add_argument('--id', required=True)
    parser.add_argument('--content', required=True)

    args = parser.parse_args()

    constitution = Constitution()
    op = CreateArticleOperator(constitution)

    builder = GraphBuilder()
    node = builder.node(op)

    graph = builder.build(node)

    result = graph.run({
        'id': args.id,
        'content': args.content,
        'metadata': {}
    })

    print('\nSMOF EXECUTION RESULT:')
    print(result)


if __name__ == '__main__':
    main()
