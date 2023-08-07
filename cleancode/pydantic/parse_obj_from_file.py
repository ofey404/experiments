import yaml
from pydantic import BaseModel


class Config(BaseModel):
    field1: str = "default"
    field2: int = 0
    field3: str = "This should not change"


config = Config()

print("# Existing instance")
print(config.model_dump_json(indent=2))

with open("parse_obj_from_file.yaml", "r") as f:
    new_data = yaml.safe_load(f)
print("# Update with new data")
print(new_data)

config = Config.model_validate(new_data)
print("# Updated instance")
print(config.model_dump_json(indent=2))
