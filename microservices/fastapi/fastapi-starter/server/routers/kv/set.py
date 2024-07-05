from typing import Annotated, Optional

from fastapi import Body, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session

from server.components.api.db import get_session
from server.components.db.models import KeyValue

class SetResponse(BaseModel):
    updated: bool
    old_value: Optional[str] = None


def set_logic(
    key: Annotated[
        str,
        Body(description="The key to set the value for"),
    ],
    value: Annotated[
        str,
        Body(description="The value to set"),
    ],
    db: Annotated[
        Session,
        Depends(get_session)
    ]
) -> SetResponse:
    query = db.query(KeyValue).filter_by(key=key)
    exists = query.first()
    if exists:
        query.update({KeyValue.value: value})
    else:
        db.add(KeyValue(key=key, value=value))

    db.commit()

    return SetResponse(updated=bool(exists), old_value=exists.value if exists else None)
