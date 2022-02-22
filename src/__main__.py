import sys

from src import app


def main(*args: str) -> int:
    if args is None:
        app.run()
    else:
        app.run(args[0])
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1]) or 0)
