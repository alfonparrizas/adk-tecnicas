#!/bin/bash
# Check if a virtual environment is active
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "ERROR: No virtual environment detected."
    echo "Please activate your virtual environment before running this script."
    echo "Example: source .venv/bin/activate or uv venv && source .venv/bin/activate"
    exit 1
fi

echo "Virtual environment detected: $VIRTUAL_ENV"
# Proceed with development tasks...
