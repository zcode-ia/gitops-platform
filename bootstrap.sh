#!/bin/bash

enable-pre-commit() {
    if command -v pre-commit &> /dev/null; then
        pre-commit install
    else
        echo "Error: pre-commit not found! Please, install it."
        exit 1
    fi
}

enable-pre-commit
