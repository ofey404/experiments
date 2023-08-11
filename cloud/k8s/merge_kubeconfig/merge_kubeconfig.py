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
    import sys

    if len(sys.argv) != 3:
        print(f"""Usage: python {sys.argv[0]} <kubeconfig1> <kubeconfig2>

Merged kubeconfig will go to stdout""")
        exit(1)
    main(
        Path(sys.argv[1]),
        Path(sys.argv[2]),
    )
