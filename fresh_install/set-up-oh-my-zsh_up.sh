
#!/bin/zsh

# Set Zsh as the default shell if it's not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as the default shell..."
    chsh -s $(which zsh)
else
    echo "Zsh is already the default shell."
fi

# Install Oh My Zsh if it's not installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed."
else
    echo "Installing Oh My Zsh..."
    # You can replace this with a non-interactive installation if you prefer
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Spaceship prompt if it's not installed
if [ -d "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt" ]; then
    echo "Spaceship prompt is already installed."
else
    echo "Installing Spaceship prompt..."
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt" --depth=1
    ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
fi

# Set Zsh theme to Spaceship if it's not already configured
ZSHRC_FILE="$HOME/.zshrc"
if grep -q "ZSH_THEME=\"spaceship\"" "$ZSHRC_FILE"; then
    echo "Spaceship theme is already set in .zshrc."
else
    echo "Setting Spaceship theme in .zshrc..."
    sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="spaceship"/' "$ZSHRC_FILE"
fi

# Apply the changes
echo "Reloading .zshrc..."
source "$ZSHRC_FILE"

echo "Zsh, Oh My Zsh, and Spaceship prompt setup is complete."


