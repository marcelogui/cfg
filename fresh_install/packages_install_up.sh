#!/bin/bash

# remember to run chmod +x ./install.sh

# Define the path to the file containing package names and optional repositories
PACKAGE_FILE="packages.txt"

# Check if the package file exists
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Package file $PACKAGE_FILE does not exist."
    exit 1
fi

# Update the package list
sudo apt-get update

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

    # Check if the repository needs to be added
    if [ -n "$REPO" ]; then
        # Extract PPA name (for more accurate comparison)
        PPA_NAME=$(echo "$REPO" | sed -e 's/^ppa://')

        # Check if the PPA is already added
        if ! grep -r "${PPA_NAME}" /etc/apt/sources.list.d/ &>/dev/null; then
            echo "Adding repository $REPO..."
            sudo add-apt-repository -y "$REPO"
            REPO_ADDED=true
        else
            echo "Repository $REPO is already added."
        fi
    fi

    # Check if the package is installed
    if dpkg -l | grep -q "^ii  $PACKAGE "; then
        echo "$PACKAGE is already installed."
    else
        echo "$PACKAGE is not installed. Installing..."
        sudo apt-get install -y "$PACKAGE"
    fi
done < "$PACKAGE_FILE"
