from typing import List
from dataclasses import dataclass
import jsonargparse


@dataclass
class Meta:
    id: str


@dataclass
class Contact:
    city: str
    email: str
    phone: List[str]
    meta: Meta


def command(name: str, contact: Contact, prize: int = 100):
    """Prints the prize won by a person.

    Args:
        name: Name of winner.
        prize: Amount won.
    """
    print(f"{name} won {prize}€!")
    if contact:
        print(f"Contact info: {contact}")


if __name__ == "__main__":
    jsonargparse.CLI(command)
