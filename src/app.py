def run(name: str = "World") -> int:
    """This function is the entry point of the application program.
    It essentially greets the string passed as parameter 'name'.

    .. note::
       Instead of a function the entry point could be a method 'run'
       in a class 'App' for instance

    :Example:

    >>> from src import app
    >>> app.run("Giacomo")
    Hello Giacomo!
    0

    :param str name: the name to greet, defaults to 'World'
    :return: return code
    :rtype: int
    :raises Exception: in-built base class for exceptions
    """
    print(f"Hello {name}!")
    return 0
