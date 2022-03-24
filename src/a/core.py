from . import helpers


def get_hmm() -> str:
    """Get a thought."""
    return "hmmm..."


def hmm() -> None:
    """Contemplation..."""
    if helpers.get_answer():
        print(get_hmm())
