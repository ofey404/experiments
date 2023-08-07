import os
import sys
import tos
import requests

# https://www.volcengine.com/docs/6349/135725

if len(sys.argv) != 3:
    print(f"""Upload with presigned URL

Usage:
  python {sys.argv[0]} file_path presigned_URL
""")
    os._exit(1)

file_path, presigned_url = sys.argv[1:]

print(f"file_path = {file_path}")
print(f"presigned_url = {presigned_url}")

with open(file_path, "rb") as f:
    content = f.read()
    out = requests.put(presigned_url, content)
    out.close()
    if out.status_code != 200:
        raise Exception(
            f"upload failed: {out.status_code} {out.text}"
        )

print("uploaded")
