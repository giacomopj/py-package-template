#!/bin/bash

# Run all code pre-commit checks
printf "\nRunning code pre-commit checks\n"
pre-commit run --all-files

# Run the application executable
printf "\nRunning application executable with example parameter\n"
python -m src Container

# Run console
/bin/bash