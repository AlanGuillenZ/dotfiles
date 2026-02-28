# Dotfiles mínimos (Ghostty + Starship + Bash/Zsh)

Este repositorio configura un entorno de terminal ligero y portable para **macOS** y **Linux**.

## Qué incluye

- `ghostty/config`: tema y tipografía para Ghostty.
- `starship/starship.toml`: prompt simple con directorio + git.
- `bash/.bashrc`: inicialización segura de Starship para Bash.
- `zsh/.zshrc`: inicialización segura de Starship para Zsh.
- `install.sh`: instalador POSIX (`sh`) con symlinks, backup automático y detección de carpetas/shells.

## Instalación

```bash
sh ./install.sh
```

El script:

1. Detecta si las carpetas necesarias ya existen (y solo las crea si faltan).
2. Crea symlinks a tus dotfiles.
3. Hace backup si encuentra archivos locales que no son symlinks.
4. Detecta si tienes `bash`, `zsh` o ambos y configura lo disponible.
5. Muestra recomendaciones específicas para macOS o Linux.

## Si GitHub marca conflicto en tu PR

Si GitHub muestra **"This branch has conflicts"** en `README.md` o `install.sh`, actualiza tu rama con `main` y resuelve localmente:

```bash
git fetch origin
git rebase origin/main
# resuelve conflictos, luego:
git add README.md install.sh
git rebase --continue
git push --force-with-lease
```

Si prefieres merge:

```bash
git fetch origin
git merge origin/main
git push
```

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
- Bash y Zsh cargan Starship solo si está instalado (sin romper el shell si falta).
