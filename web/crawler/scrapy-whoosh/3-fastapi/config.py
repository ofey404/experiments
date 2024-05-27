import logging
from pathlib import Path

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Config(BaseSettings):
    """https://docs.pydantic.dev/latest/concepts/pydantic_settings/"""

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    host: str = "0.0.0.0"
    port: int = 8888
    uvicorn_kwargs: dict = Field(default_factory=dict)
    logging_basic_config: dict = Field(
        default_factory=lambda: {"level": logging.WARNING}
    )

    crawl_start_url: str = "https://docusaurus.io/zh-CN/docs/category/getting-started"
    crawl_limit: int | None = 5
    index_dir: Path = Path("./indexdir")


CONFIG = Config()
