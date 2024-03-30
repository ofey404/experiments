import logging
from contextlib import asynccontextmanager

import yaml
from fastapi import FastAPI

from config import CONFIG
from server.components.db.connect import Base, engine

LOGGER = logging.getLogger(__name__)

@asynccontextmanager
async def lifespan(app: FastAPI):
    # startup
    LOGGER.info("Executing lifespan startup code")
    LOGGER.debug(f"""App config:
{yaml.dump(CONFIG.model_dump())}""")


    Base.metadata.create_all(bind=engine)

    yield

    # shutdown
    LOGGER.info("Executing lifespan shutdown code")
