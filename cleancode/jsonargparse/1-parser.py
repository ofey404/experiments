from jsonargparse import CLI


def command(name: str, prize: int = 100):
    """Prints the prize won by a person.

    Args:
        name: Name of winner.
        prize: Amount won.
    """
    print(f"{name} won {prize}€!")


if __name__ == "__main__":
    CLI(command)