#!/bin/bash

# Define the path to the file containing package names and optional repositories
PACKAGE_FILE="packages.txt"

# Check if the package file exists
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Package file $PACKAGE_FILE does not exist."
    exit 1
fi

# Read each line from the package file
while IFS= read -r LINE; do
    # Skip empty lines and lines starting with '#'
    [ -z "$LINE" ] || [[ "$LINE" == \#* ]] && continue

    # Check if the line contains a '|'
    if echo "$LINE" | grep -q '|'; then
        # Split the line into package and repository parts
        PACKAGE=$(echo "$LINE" | cut -d'|' -f1 | xargs)
        REPO=$(echo "$LINE" | cut -d'|' -f2 | xargs)
    else
        # If no '|', the whole line is the package, no repository
        PACKAGE=$(echo "$LINE" | xargs)
        REPO=""
    fi

    # Remove the package if it's installed
    if dpkg -l | grep -q "^ii  $PACKAGE "; then
        echo "Removing package $PACKAGE..."
        sudo apt-get remove --purge -y "$PACKAGE"
    else
        echo "Package $PACKAGE is not installed."
    fi

    # Remove the PPA repository if it exists
    if [ -n "$REPO" ]; then
        PPA_NAME=$(echo "$REPO" | sed -e 's/^ppa://')
        if grep -r "${PPA_NAME}" /etc/apt/sources.list.d/ &>/dev/null; then
            echo "Removing repository $REPO..."
            sudo add-apt-repository --remove -y "$REPO"
        else
            echo "Repository $REPO is not found."
        fi
    fi
done < "$PACKAGE_FILE"

# Clean up any unused packages and dependencies
sudo apt-get autoremove -y
sudo apt-get clean

echo "All specified packages and repositories have been removed."
