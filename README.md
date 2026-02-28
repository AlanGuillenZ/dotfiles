# Dotfiles mínimos (Ghostty + Starship + Zsh)

Este repositorio configura un entorno de terminal ligero y portable para **macOS** y **Linux**.

## Qué incluye

- `ghostty/config`: tema y tipografía para Ghostty.
- `starship/starship.toml`: prompt simple con directorio + git.
- `zsh/.zshrc`: inicialización segura de Starship para Zsh.
- `install.sh`: instalador con symlinks, backup automático y mensajes por plataforma.

## Instalación

```bash
./install.sh
```

El script:

1. Crea las carpetas necesarias en `~/.config`.
2. Crea symlinks a tus dotfiles.
3. Hace backup si encuentra archivos locales que no son symlinks.
4. Muestra recomendaciones específicas para macOS o Linux.

## Requisitos recomendados

### macOS

```bash
brew install starship
brew install --cask font-jetbrains-mono-nerd-font
```

### Linux

Instala:

- `starship`
- `JetBrains Mono Nerd Font`

Puedes usar tu gestor de paquetes favorito (apt, dnf, pacman, etc.).

## Resultado esperado

- Ghostty usa tema TokyoNight y JetBrains Mono Nerd Font.
- Zsh carga Starship solo si está instalado (sin romper el shell si falta).

