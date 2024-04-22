from typing import Any, Callable, Set

from pydantic import (
    AliasChoices,
    AmqpDsn,
    BaseModel,
    Field,
    ImportString,
    PostgresDsn,
    RedisDsn,
)

from pydantic_settings import BaseSettings, SettingsConfigDict


class SubModel(BaseModel):
    foo: str = "bar"
    apple: int = 1


class Settings(BaseSettings):
    auth_key: str = Field(validation_alias="my_auth_key")

    api_key: str = Field(alias="my_api_key")

    redis_dsn: RedisDsn = Field(
        "redis://user:pass@localhost:6379/1",
        validation_alias=AliasChoices("service_redis_dsn", "redis_url"),
    )
    pg_dsn: PostgresDsn = "postgres://user:pass@localhost:5432/foobar"
    amqp_dsn: AmqpDsn = "amqp://user:pass@localhost:5672/"

    special_function: ImportString[Callable[[Any], Any]] = "math.cos"

    # to override domains:
    # export my_prefix_domains='["foo.com", "bar.com"]'
    domains: Set[str] = set()

    # to override more_settings:
    # export my_prefix_more_settings='{"foo": "x", "apple": 1}'
    more_settings: SubModel = SubModel()

    model_config = SettingsConfigDict(env_prefix="my_prefix_")


print(Settings().model_dump())
"""
MY_AUTH_KEY=xxx MY_API_KEY=xxx python 1-settings.py
{
    'auth_key': 'xxx',
    'api_key': 'xxx',
    'redis_dsn': Url('redis://user:pass@localhost:6379/1'),
    'pg_dsn': MultiHostUrl('postgres://user:pass@localhost:5432/foobar'),
    'amqp_dsn': Url('amqp://user:pass@localhost:5672/'),
    'special_function': math.cos,
    'domains': set(),
    'more_settings': {'foo': 'bar', 'apple': 1},
}
"""
