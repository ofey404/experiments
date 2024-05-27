import json
import sys
from pathlib import Path

# Get the absolute path to the backend directory
project_root = Path(__file__).resolve().parent.parent

# Add the backend directory to the sys.path
sys.path.append(str(project_root))

from server import app

schema_file = Path("openapi.json")
with open(schema_file, "w") as f:
    json.dump(app.openapi(), f)

print(f"Generated OpenAPI schema to {schema_file.absolute()}")
