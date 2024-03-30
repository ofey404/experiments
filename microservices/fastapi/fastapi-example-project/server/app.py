from fastapi import FastAPI

from server.lifespan import lifespan
from server.routers import kv

app = FastAPI(
    title="FastAPI Example Project API Server",
    lifespan=lifespan
)

app.include_router(
    kv.router,
    prefix="/chat",
)

# more routers ...
