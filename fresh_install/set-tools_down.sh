#!/bin/zsh

# Uninstall Docker if installed
if command -v docker >/dev/null 2>&1; then
    echo "Docker found, uninstalling..."

    sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
else
    echo "Docker is already uninstalled.";
fi

# Uninstall Neovim if installed

# Uninstall Slack if installed

# Uninstall Visual Studio Code if installed

# youtube-music

# bruno

# mongodb-compass




