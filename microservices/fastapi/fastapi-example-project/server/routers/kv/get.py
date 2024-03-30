from typing import Annotated

from fastapi import Body, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session

from server.components.api.db import get_session
from server.components.db.models import KeyValue


class GetResponse(BaseModel):
    key: str
    value: str

def get_logic(
    key: Annotated[
        str,
        Body(description="The key to get the value for")
    ],
    db: Annotated[
        Session,
        Depends(get_session)
    ]
) -> GetResponse:
    kv = db.query(KeyValue).filter_by(key=key).first()
    return GetResponse(key=key, value=kv.value)