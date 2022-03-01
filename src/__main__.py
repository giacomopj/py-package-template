import sys
from typing import List

from src import app


def main(args: List[str]) -> int:
    if args:
        for arg in args:
            app.run(arg)
    else:
        app.run()
    return 0


if __name__ == "__main__":
    if len(sys.argv) > 1:
        sys.exit(main(sys.argv[1:]))
    else:
        sys.exit(main([]))
