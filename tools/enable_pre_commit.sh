#!/bin/bash

enable-pre-commit() {
    # Check if pre-commit is installed
    if command -v pre-commit &> /dev/null; then
        # Install pre-commit hooks
        pre-commit install
    else
        # Print error message if pre-commit is not found
        echo "Error: pre-commit not found! Please, install it."
        exit 1
    fi
}

enable-pre-commit
