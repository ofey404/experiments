import logging

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Config(BaseSettings):
    """https://docs.pydantic.dev/latest/concepts/pydantic_settings/"""

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    host: str = "0.0.0.0"
    port: int = 80
    uvicorn_kwargs: dict = Field(default_factory=dict)
    logging_basic_config: dict = Field(
        default_factory=lambda: {"level": logging.WARNING}
    )
    db_url: str = "sqlite:///./sql_app.db"


CONFIG = Config()
