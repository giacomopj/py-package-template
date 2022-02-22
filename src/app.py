def run(name: str = "World") -> int:
    """This function is the entry point of the application.
    It essentially greets :param:`name`.
    .. note:: Note that the entry point could be also the method
    of a class :class:`App`

    :Example:

    >>> from src import app
    >>> app.run("Giacomo")
    Hello Giacomo!
    0

    :param name: The name to use, defaults to "World"
    :type name: str, optional
    ...
    :raises Exception: The in-built base class for exceptions
    ...
    :return: Return code
    :rtype: int
    """
    print(f"Hello {name}!")
    return 0
