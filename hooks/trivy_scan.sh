#!/bin/bash

# Define the path to the Trivy configuration file
CONFIG_FILE="$(dirname "$0")/trivy.yaml"

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Trivy configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Loop through all passed files or directories
for file in "$@"; do
    echo "Scanning $file with Trivy using config $CONFIG_FILE..."

    # Capture the exit code of Trivy
    if ! trivy config -c "$CONFIG_FILE" "$file"; then
        echo "Trivy scan failed for $file"
        exit 1
    fi
done
