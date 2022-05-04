#!/bin/bash

# Exit immediately if a command exits with a non-zero status (very restritive)
# set -e

# Run all code pre-commit checks
printf "\nRunning code pre-commit checks\n"
pre-commit run --all-files

# Run all unit tests
printf "\nRunning unit tests\n"
pytest
pytest --cov --cov-fail-under=90

# Run terminal with bash shell
/bin/bash
