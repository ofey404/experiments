import os

try:
    print(os.extrakey)
except AttributeError:
    print("os.extrakey not found")
