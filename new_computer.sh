#!/bin/bash
set -e

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install all packages from Brewfile
brew bundle --file="$HOME/.dotfiles/brew/Brewfile"

# Set up symlinks for configs
"$HOME/.dotfiles/install.sh"
