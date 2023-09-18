from pathlib import Path
try:
    import hiyapyco
except ImportError:
    print("""Please install hiyapyco first:

pip install HiYaPyCo==0.5.1""")


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
    import os
    import sys
    print("This script has bug. Do not use it.", file=sys.stderr)
    os._exit(1)

    if len(sys.argv) != 3:
        print(f"""Usage: python {sys.argv[0]} <yaml1> <yaml2>

Merged yaml will go to stdout""")
        exit(1)
    main(
        Path(sys.argv[1]),
        Path(sys.argv[2]),
    )
