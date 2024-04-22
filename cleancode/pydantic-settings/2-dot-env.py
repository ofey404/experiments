from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    # The latter overrides the former, .env.prod has higher priority
    model_config = SettingsConfigDict(env_file=(".env", ".env.prod"))

    my_field_1: str = Field()


print(Settings().model_dump())
