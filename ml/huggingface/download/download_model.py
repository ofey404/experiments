import os
import huggingface_hub
import jsonargparse


def download(
    name: str,
    dir: str,
    revision: str = None,
    overwrite_existed_download: bool = False,
):
    if not overwrite_existed_download:
        if os.path.exists(dir):
            raise ValueError(f"Directory {dir} exists.")

    huggingface_hub.snapshot_download(
        name,
        local_dir=dir,
        revision=revision,
    )


if __name__ == "__main__":
    jsonargparse.CLI(download)
