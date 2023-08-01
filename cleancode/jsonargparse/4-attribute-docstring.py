from typing import List
import jsonargparse
from dataclasses import dataclass
from jsonargparse import set_docstring_parse_options

set_docstring_parse_options(attribute_docstrings=True)


@dataclass
class NestedOptions:
    """Options for a competition winner."""

    city: str
    """City of winner."""
    email: str
    """Email of winner."""


@dataclass
class OptionalNestedOptions:
    phone: List[str] = None
    """Phone numbers of winner."""


@dataclass
class Options:
    """Options for a competition winner."""

    name: str
    """Name of winner."""
    residence: NestedOptions
    """Residence is a nested option."""
    prize: int = 100
    """Amount won."""
    metadata: OptionalNestedOptions = None
    """Metadata is a optional nested option."""


def command(options: Options):
    """Prints the prize won by a person.

    Args:
        options: Options for a competition winner.
    """

    print(f"{options.name} won {options.prize}€!")


if __name__ == "__main__":
    jsonargparse.CLI(command)
