from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class SearchRequestBody(BaseModel):
    keyword: str


@app.post("/search")
async def search(request_body: SearchRequestBody):
    keyword = request_body.keyword
    # TODO: Perform search with keyword
    return {"message": f"Search for {keyword} is not yet implemented."}


@app.get("/rebuild")
async def rebuild_index():
    # TODO: Rebuild search index
    return {"message": "Rebuilding index is not yet implemented."}
