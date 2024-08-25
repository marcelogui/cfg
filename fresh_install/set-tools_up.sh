#!/bin/zsh

export NVM_DIR="$HOME/.nvm"

# install nvm if not already installed
if [ ! -d $NVM_DIR ]; then
    echo "NVM not found, installing..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    # Loads environment variables and nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 20;
else
    echo "NVM is already installed."
fi

# Install Docker if not already installed
if ! command -v docker >/dev/null 2>&1; then
    echo "Docker not found, installing..."
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    # Install packages
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;
else
    echo "Docker is already installed.";
fi

# Install Neovim if not already installed
if ! command -v nvim >/dev/null 2>&1; then
    echo "Neovim not found, installing..."
    wget -O "${HOME}/Downloads/nvim.tar.gz" https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
    sudo tar xzvf "${HOME}/Downloads/nvim.tar.gz" -C /usr/local
    sudo ln -s /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim
    rm "${HOME}/Downloads/nvim.tar.gz";
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
else
    echo "Neovim is already installed.";
fi

# Install Slack if not already installed
if ! command -v slack >/dev/null 2>&1; then
    echo "Slack not found, installing..."
    wget -O "${HOME}/Downloads/slack.deb" https://downloads.slack-edge.com/desktop-releases/linux/x64/4.39.95/slack-desktop-4.39.95-amd64.deb
    sudo apt install -y "${HOME}/Downloads/slack.deb"
    rm "${HOME}/Downloads/slack.deb";
else
    echo "Slack is already installed.";
fi

# Install Visual Studio Code if not already installed
if ! command -v code >/dev/null 2>&1; then
    echo "Visual Studio Code not found, installing..."
    wget -O "${HOME}/Downloads/vscode.deb" https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
    sudo apt install -y "${HOME}/Downloads/vscode.deb"
    rm "${HOME}/Downloads/vscode.deb";
else
    echo "Visual Studio Code is already installed."
fi

# youtube-music

# bruno

# mongodb-compass




