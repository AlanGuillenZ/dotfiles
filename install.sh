#!/usr/bin/env sh
set -eu

DOTFILES_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
OS=$(uname -s)
CURRENT_SHELL=$(basename "${SHELL:-unknown}")

ensure_dir() {
  dir_path="$1"
  if [ -d "$dir_path" ]; then
    echo "📁 Ya existe: $dir_path"
  else
    mkdir -p "$dir_path"
    echo "📁 Creada: $dir_path"
  fi
}

create_symlink() {
  source_file="$1"
  target_file="$2"

  # Quita symlink previo o archivo normal después del backup.
  if [ -L "$target_file" ] || [ -e "$target_file" ]; then
    rm -f "$target_file"
  fi

  ln -s "$source_file" "$target_file"
  echo "🔗 Vinculado: $target_file -> $source_file"
}

link_file() {
  source_file="$1"
  target_file="$2"
  target_dir=$(dirname "$target_file")

  if [ ! -f "$source_file" ]; then
    echo "⚠️  No existe el archivo fuente: $source_file"
    return 0
  fi

  ensure_dir "$target_dir"

  if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
    backup_file="${target_file}.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target_file" "$backup_file"
    echo "📦 Backup creado: $backup_file"
  fi

  create_symlink "$source_file" "$target_file"
}

setup_shell_configs() {
  has_shell=0

  if command -v bash >/dev/null 2>&1; then
    has_shell=1
    link_file "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
  fi

  if command -v zsh >/dev/null 2>&1; then
    has_shell=1
    link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
  fi

  if [ "$has_shell" -eq 0 ]; then
    echo "⚠️  No se detectó bash ni zsh en este sistema."
  fi

  echo "🐚 Shell actual detectada: $CURRENT_SHELL"
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

ensure_dir "$HOME/.config"
ensure_dir "$HOME/.config/ghostty"

link_file "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
setup_shell_configs

echo "✅ Dotfiles instalados correctamente."
print_next_steps
