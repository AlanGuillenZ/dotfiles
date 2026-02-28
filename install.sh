#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/ghostty"

ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo "✅ Symlinks listos."

# Detect OS
OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
  echo "🍎 macOS detectado."
  echo "Tip: instala fonts con brew cask (ej. font-jetbrains-mono-nerd-font) y starship si no lo tienes."
elif [[ "$OS" == "Linux" ]]; then
  echo "🐧 Linux detectado."
  echo "Tip: en Mint instala starship + nerd fonts y recarga tu shell."
else
  echo "ℹ️ OS no reconocido: $OS"
fi
