from pprint import pprint
from whoosh.index import open_dir
from whoosh.qparser import QueryParser


def print_index():
    # Open the index directory
    ix = open_dir("indexdir")
    print(f"ix.doc_count_all() = {ix.doc_count_all()}")

    # Create a searcher
    with ix.searcher() as searcher:
        # Create a query parser that searches the 'content' field
        parser = QueryParser("content", ix.schema)

        # Parse a query that matches everything
        query = parser.parse("*")

        # Run the query and print out the results
        results = searcher.search(query, limit=100)
        for hit in results:
            pprint(hit)


if __name__ == "__main__":
    print_index()
