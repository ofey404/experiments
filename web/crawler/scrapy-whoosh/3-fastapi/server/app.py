from fastapi import FastAPI
from pydantic import BaseModel
from whoosh.index import open_dir
from whoosh.qparser import QueryParser

from config import CONFIG
from server.lifespan import lifespan

app = FastAPI(
    lifespan=lifespan,
)


class SearchRequestBody(BaseModel):
    keyword: str


@app.post("/search")
async def search(request_body: SearchRequestBody):
    idx = open_dir(CONFIG.index_dir)
    query = QueryParser("content", idx.schema).parse(request_body.keyword)
    with idx.searcher() as searcher:
        results = searcher.search(query, limit=CONFIG.search_limit)
        return {"results": results_to_json(results)}

def results_to_json(results):
    # Convert Whoosh results to JSON-serializable format
    json_results = []
    for result in results:
        json_result = {}
        for field in result.fields():
            json_result[field] = result[field]
        json_results.append(json_result)
    return json_results
