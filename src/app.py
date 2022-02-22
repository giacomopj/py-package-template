def run(name: str = "World") -> int:
    """This function is the entry point of the application.
    It essentially greets 'name'.

    .. note::
       The entry point could be also a method 'run' of a class 'App'

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
