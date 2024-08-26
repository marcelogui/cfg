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

if ! command -v youtube-music >/dev/null 2>&1; then
    echo "Youtube-Music not found, installing..."
    wget -O "${HOME}/Downloads/youtube-music.deb" https://github.com/th-ch/youtube-music/releases/download/v3.5.1/youtube-music_3.5.1_amd64.deb
    sudo apt install -y "${HOME}/Downloads/youtube-music.deb"
    rm "${HOME}/Downloads/youtube-music.deb";

    # Create the AppArmor profile file
    sudo tee /etc/apparmor.d/youtube-music > /dev/null << 'EOF'
# This profile adds the "userns" flags to the otherwise "unrestricted" flags, this is needed, since electron uses user namespaces (userns) to run a sandbox, and this app uses electron

abi <abi/4.0>,
include <tunables/global>

profile youtube-music "/opt/YouTube Music/youtube-music" flags=(unconfined) {
  userns,

  # Site-specific additions and overrides. See local/README for details.
  include if exists <local/youtube-music>
}
EOF

    # Reload AppArmor profiles
    sudo systemctl reload apparmor
else
    echo "Youtube-Music is already installed."
fi



# bruno

# mongodb-compass

if ! command -v mongodb-compass >/dev/null 2>&1; then
    echo "Mongodb-Compass not found, installing..."
    wget -O "${HOME}/Downloads/mongodb-compass.deb" https://downloads.mongodb.com/compass/mongodb-compass_1.43.6_amd64.deb
    sudo apt install -y "${HOME}/Downloads/mongodb-compass.deb"
    rm "${HOME}/Downloads/mongodb-compass.deb";
else
    echo "MongoDB Compass is already installed."
fi




