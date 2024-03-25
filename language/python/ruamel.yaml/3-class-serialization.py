import sys
from typing import Any, Dict, List
from pydantic import BaseModel
import ruamel.yaml

class NestedConfig(BaseModel):
    entry: str = "foo"
    dict_entry: Dict[str, str] = {
        "foo": "bar",
    }

class Config(BaseModel):
    entry: str = "foo"
    dict_entry: Dict[str, str] = {
        "foo": "bar",
        "bar": "baz"
    }

    list_entry: List[int] = [1, 2, 3]
    nested_entry: NestedConfig = NestedConfig()

data = Config().model_dump()

yaml = ruamel.yaml.YAML()
yaml.dump(data, sys.stdout)
