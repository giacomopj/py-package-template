#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run all code pre-commit checks
printf "\nRunning code pre-commit checks\n"
pre-commit run --all-files

# Run all unit tests
printf "\nRunning unit tests\n"
pytest
pytest --cov --cov-fail-under=100

# Run the application executable
printf "\nRunning application executable with example parameter\n"
python -m src Tester Container

# Run console
/bin/bash
