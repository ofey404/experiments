from typing import Annotated

from fastapi import Depends
from sqlalchemy.orm import Session

from server.components.api.common_args import CommonArgs, get_common_args
from server.components.db.connect import SessionFactory


def get_session(
        common_args: Annotated[
            CommonArgs,
            Depends(get_common_args)
        ]
) -> Session:
    db: Session = SessionFactory()

    try:
        yield db
    finally:
        db.close()
