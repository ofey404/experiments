from fastapi import APIRouter

from .get import get_logic
from .set import set_logic

router = APIRouter()

router.post("/get")(get_logic)
router.post("/set")(set_logic)

__all__ = [router]
