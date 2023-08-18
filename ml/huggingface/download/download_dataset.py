import os
import jsonargparse
from datasets import load_dataset


def download(
    name: str,
    dir: str,
    overwrite_existed_download: bool = False,
):
    if not overwrite_existed_download:
        if os.path.exists(dir):
            raise ValueError(f"Directory {dir} exists.")

    load_dataset(name).save_to_disk(dir)


if __name__ == "__main__":
    jsonargparse.CLI(download)
