#!/bin/bash

# Exit immediately if a command exits with a non-zero status (very restritive)
# set -e

# Run debugger
printf "\nRunning debugger\n"
python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m src Debugger Container

# Run console
/bin/bash
