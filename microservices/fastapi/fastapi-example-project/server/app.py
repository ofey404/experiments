from fastapi import FastAPI
import re

from server.lifespan import lifespan
from server.routers import kv
from fastapi.routing import APIRoute

def generate_unique_id(route: APIRoute) -> str:
    """https://fastapi.tiangolo.com/advanced/generate-clients/#custom-generate-unique-id-function"""
    assert route.path_format[0] == "/"
    return re.sub(r"\W", "_", route.path_format[1:])

app = FastAPI(
    title="FastAPI Example Project API Server",
    lifespan=lifespan,
    generate_unique_id_function=generate_unique_id
)

app.include_router(
    kv.router,
    prefix="/kv",
)

# more routers ...
