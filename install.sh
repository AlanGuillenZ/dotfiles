#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

link_file() {
  local source_file="$1"
  local target_file="$2"

  if [[ ! -f "$source_file" ]]; then
    echo "⚠️  No existe el archivo fuente: $source_file"
    return
  fi

  mkdir -p "$(dirname "$target_file")"

  if [[ -e "$target_file" && ! -L "$target_file" ]]; then
    local backup_file="${target_file}.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target_file" "$backup_file"
    echo "📦 Backup creado: $backup_file"
  fi

  ln -sfn "$source_file" "$target_file"
  echo "🔗 Vinculado: $target_file -> $source_file"
}

print_next_steps() {
  case "$OS" in
    Darwin)
      cat <<'MAC'
🍎 macOS detectado.
Siguientes pasos recomendados:
  1) Instala Starship: brew install starship
  2) Instala Nerd Font: brew install --cask font-jetbrains-mono-nerd-font
  3) Reinicia Ghostty y tu shell.
MAC
      ;;
    Linux)
      cat <<'LINUX'
🐧 Linux detectado.
Siguientes pasos recomendados:
  1) Instala Starship (paquete oficial o script de instalación).
  2) Instala una Nerd Font (JetBrains Mono Nerd Font).
  3) Reinicia Ghostty y tu shell.
LINUX
      ;;
    *)
      echo "ℹ️ Sistema no reconocido: $OS"
      ;;
  esac
}

link_file "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo "✅ Dotfiles instalados correctamente."
print_next_steps
