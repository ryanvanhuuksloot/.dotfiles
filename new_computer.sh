# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew packages
brew install kubectx
brew install fzf
brew install ripgrep

# IDE Configurations
# ===========================
# Configs in ~/.configs/ghostty && ~/.configs/zellij && ~/.configs/starship.toml
# Install Starship
curl -fsSL https://starship.rs/install.sh | bash -s -- --yes
# Install Zellij
brew install zellij
# Install Ghostty (GUI for Zellij)
brew install ghostty
# Font is JetBrains Mono
brew install --cask jetbrains-mono