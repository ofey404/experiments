import os
import click
from pydantic import BaseModel
from pathlib import Path


class Repo(BaseModel):
    home: Path = Path.home()
    comment: str = ""


class Stash(BaseModel):
    file_list: list = []


@click.group()
@click.option('--repo-home', envvar='REPO_HOME', default='.repo')
@click.option('--debug/--no-debug', default=False, envvar='REPO_DEBUG')
@click.pass_context
def cli(ctx: click.Context, repo_home, debug):
    print("cli() called")
    ctx.obj = Repo(comment="created in cli()")
    print(f"repo_home = {repo_home}")
    print(f"debug = {debug}")


@cli.group()
@click.pass_context
def stash(ctx: click.Context):
    """This is not a complete simulation of the actual `git stash pop`
    parsing behavior,
    because `stash` cannot be both a group and a command.
    
    It's just for demonstration purposes.
    """
    print("stash() called")
    repo = ctx.ensure_object(Repo)
    print(f"Repo JSON = {repo.model_dump_json()}")
    ctx.obj = Stash(file_list=["file1", "file2"])


@stash.command()
@click.pass_context
def pop(ctx: click.Context):
    print("pop() called")
    stash = ctx.ensure_object(Stash)
    repo = ctx.ensure_object(Repo)
    print(f"Stash JSON = {stash.model_dump_json()}")
    print(f"Repo JSON = {repo.model_dump_json()}")


if __name__ == "__main__":
    cli()
