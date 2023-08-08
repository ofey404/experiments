import os
import sys
import tos
from client import new_client, BUCKET

# https://www.volcengine.com/docs/6349/135725

if len(sys.argv) != 2:
    print(f"""Generate a presigned URL

Usage:
  python {sys.argv[0]} object_key
""")
    os._exit(1)

client = new_client()

out = client.pre_signed_url(
    tos.HttpMethodType.Http_Method_Put,
    bucket=BUCKET,
    key=sys.argv[1],
    expires=3600,
)

print(f"object = tos://{BUCKET}/{sys.argv[1]}")
print(f"signed_url = {out.signed_url}")
