#!/bin/zsh

rm -rf "${HOME}/dotfiles"
git clone https://github.com/marcelogui/cfg.git "${HOME}/dotfiles"
cd "${HOME}/dotfiles"
stow --adopt .

