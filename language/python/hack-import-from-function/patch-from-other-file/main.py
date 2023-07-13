import os

from patch import patch_os_extrakey

patch_os_extrakey()

try:
    print(f"os.extrakey = {os.extrakey}")
except AttributeError:
    print("os.extrakey not found")
