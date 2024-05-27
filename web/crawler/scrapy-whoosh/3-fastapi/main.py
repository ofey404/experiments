import logging

import uvicorn

from config import CONFIG

# logging config should be applied before importing the app
logging.basicConfig(**CONFIG.logging_basic_config)

from server.app import app

if __name__ == "__main__":
    uvicorn.run("main:app", host=CONFIG.host, port=CONFIG.port, **CONFIG.uvicorn_kwargs)
