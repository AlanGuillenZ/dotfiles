if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  echo "⚠️  Starship no está instalado. Instálalo para usar el prompt personalizado."
fi
