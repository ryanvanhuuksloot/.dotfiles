#!/bin/bash
# Dotfiles install script — creates symlinks from dotfiles repo to expected locations
set -e

DOTFILES="$HOME/.dotfiles"

link() {
  local src="$DOTFILES/$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "  backing up $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -s "$src" "$dst"
  echo "  $dst → $src"
}

echo "Installing dotfiles..."
link "starship/starship.toml"              "$HOME/.config/starship.toml"
link "ghostty/config"                      "$HOME/.config/ghostty/config"
link "zellij/config.kdl"                   "$HOME/.config/zellij/config.kdl"
link "claude/skills/gt/SKILL.md"           "$HOME/.claude/skills/gt/SKILL.md"
link "claude/skills/worktrees/SKILL.md"    "$HOME/.claude/skills/worktrees/SKILL.md"
echo "Done!"
