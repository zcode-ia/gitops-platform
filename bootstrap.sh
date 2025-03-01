#!/bin/bash

enable-pre-commit() {
    if command -v pre-commit &> /dev/null; then
        pre-commit install
    else
        echo "Error: pre-commit not found! Please, install it."
        exit 1
    fi
}

# This function only extracts binary files (excluding common text files)
# and only if they have not already been extracted (i.e., they don't exist in the destination directory).
# It works for both ZIP and TAR.GZ files.
extract_if_needed() {
    local file="$1"
    local binary_files


    # Determine the command to list files based on file type
    if [[ "$file" == *.zip ]]; then
        binary_files=$(unzip -Z1 "$file" | grep -vE -e '\.(txt|md|html|csv|json|xml|yaml|log|tpl)$' -e 'LICENSE')
    elif [[ "$file" == *.tar.gz ]]; then
        binary_files=$(tar -tzf "$file" | grep -vE -e '\.(txt|md|html|csv|json|xml|yaml|log|tpl)$' -e 'LICENSE')
    else
        return
    fi


    [[ -z "$binary_files" ]] && echo "No binary files found in $file, skipping." && return


    # Check if any of the binary files already exist
    for f in $binary_files; do
        if [[ -e "$dest_dir/$f" ]]; then
            echo " - Skipping $f, already extracted."
            return
        fi
    done


    echo " - Extracting binary files from $file..."
    if [[ "$file" == *.zip ]]; then
        unzip "$file" "$binary_files" -d "$dest_dir"
    else
        tar -xzf "$file" "$binary_files" -C "$dest_dir"
    fi
}

check-binary-files(){
    dest_dir="bin"


    echo "Checking for ${OSTYPE} binary files to extract if necessary."
    for file in "$dest_dir"/*"${OSTYPE}"*.zip "$dest_dir"/*"${OSTYPE}"*.tar.gz; do
        echo "+ Analysing: $file"
        [[ -f "$file" ]] && extract_if_needed "$file"
    done
}

# Function to enable direnv in this repository
enable-direnv() {
    if command -v direnv &> /dev/null; then
        direnv allow .
    else
        echo "Error: direnv not found! Please, install it."
        exit 1
    fi
}

enable-pre-commit
check-binary-files
enable-direnv
