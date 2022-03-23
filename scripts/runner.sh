#!/bin/bash

# Exit immediately if a command exits with a non-zero status (very restritive)
# set -e

# Run the application executable
printf "\nRunning application executable\n"
python -m src Runner Container
