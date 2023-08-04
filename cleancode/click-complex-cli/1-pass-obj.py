import os
import click
from pydantic import BaseModel
from pathlib import Path


class Repo(BaseModel):
    home: Path = Path.home()
    version: int = 0


@click.group()
@click.option('--repo-home', envvar='REPO_HOME', default='.repo')
@click.option('--debug/--no-debug', default=False, envvar='REPO_DEBUG')
@click.pass_context
def cli(ctx: click.Context, repo_home, debug):
    ctx.obj = Repo()


@cli.command()
@click.argument('src')
@click.argument('dest', required=False)
@click.pass_obj
def clone(repo: BaseModel, src, dest):
    print(f"Cloning {src} into {dest}")
    print(f"Repo JSON = {repo.model_dump_json()}")


if __name__ == "__main__":
    cli()
