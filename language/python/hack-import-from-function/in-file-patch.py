import os

os.extrakey = "extravalue"

try:
    print(f"os.extrakey = {os.extrakey}")
except AttributeError:
    print("os.extrakey not found")
