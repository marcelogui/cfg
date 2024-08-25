#!/bin/bash

# Check if Zsh is the default shell and revert to the previous shell if it was changed
if [ "$SHELL" = "$(which zsh)" ]; then
    echo "Reverting shell back to Bash..."
    chsh -s $(which bash)
else
    echo "Zsh is not the default shell, no changes needed."
fi

# Remove Oh My Zsh if it's installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Removing Oh My Zsh..."
    rm -rf "$HOME/.oh-my-zsh"
else
    echo "Oh My Zsh is not installed, no changes needed."
fi

# Revert the Zsh theme in .zshrc if it was changed
ZSHRC_FILE="$HOME/.zshrc"
if grep -q "ZSH_THEME=\"spaceship\"" "$ZSHRC_FILE"; then
    echo "Reverting Zsh theme in .zshrc to default..."
    sed -i 's/^ZSH_THEME="spaceship"/ZSH_THEME="robbyrussell"/' "$ZSHRC_FILE"
else
    echo "No changes needed to the Zsh theme in .zshrc."
fi

# Apply the changes
echo "Reloading .zshrc..."
source "$ZSHRC_FILE"

echo "Revert process is complete."
