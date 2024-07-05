from typing import Annotated

from fastapi import Body
from pydantic import BaseModel


class CommonArgs(BaseModel):
    foo: str
    bar: int

def get_common_args(
        common_args: Annotated[
            CommonArgs,
            Body(description="Common arguments for the request"),
        ]
) -> CommonArgs:
    return common_args