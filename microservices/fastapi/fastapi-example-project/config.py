import logging

from pydantic import Field
from yaml_settings_pydantic import BaseYamlSettings, YamlSettingsConfigDict, YamlFileConfigDict


class Config(BaseYamlSettings):
    """https://docs.pydantic.dev/latest/concepts/pydantic_settings/"""

    model_config = YamlSettingsConfigDict(yaml_files={
        # config loading order
        "config.yaml": YamlFileConfigDict(
            required=False,
            subpath=None,
        ),
        "etc/config.yaml": YamlFileConfigDict(
            required=False,
            subpath=None,
        ),
        "/etc/service/config.yaml": YamlFileConfigDict(
            required=False,
            subpath=None,
        ),
    }, yaml_reload=True)

    host: str = "0.0.0.0"
    port: int = 80
    uvicorn_kwargs: dict = Field(default_factory=dict)
    logging_basic_config: dict = Field(default_factory=lambda: {
        "level": logging.WARNING
    })
    db_url: str = "sqlite:///./sql_app.db"

CONFIG = Config()
