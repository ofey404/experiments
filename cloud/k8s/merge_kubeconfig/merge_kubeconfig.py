import hiyapyco
from pathlib import Path


def merge_dicts(a, b):
    """https://stackoverflow.com/questions/47424865/merge-two-yaml-files-in-python"""
    for key in b:
        if key in a:
            if isinstance(a[key], dict) and isinstance(b[key], dict):
                merge_dicts(a[key], b[key])
            else:
                a[key] = b[key]
        else:
            a[key] = b[key]
    return a


def load(path: Path) -> str:
    with open(path, "r") as f:
        return f.read()


def main(k1: Path, k2: Path):
    merged_yaml = hiyapyco.load(
        [
            load(k1),
            load(k2),
        ],
        method=hiyapyco.METHOD_MERGE,
    )
    print("## Merged YAML:")
    print(hiyapyco.dump(merged_yaml))


if __name__ == "__main__":
    import sys

    if len(sys.argv) != 3:
        print(f"""Usage: python {sys.argv[0]} <kubeconfig1> <kubeconfig2>

Merged kubeconfig will go to stdout""")
        exit(1)
    main(
        Path(sys.argv[1]),
        Path(sys.argv[2]),
    )
