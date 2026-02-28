#!/usr/bin/env sh
set -eu

BASE_BRANCH="${1:-main}"
REMOTE="${2:-origin}"

echo "🔄 Sincronizando con $REMOTE/$BASE_BRANCH..."
git fetch "$REMOTE"

echo "🧩 Rebase de la rama actual sobre $REMOTE/$BASE_BRANCH"
if git rebase "$REMOTE/$BASE_BRANCH"; then
  echo "✅ Rebase completado sin conflictos."
else
  echo "⚠️ Hay conflictos. Resuélvelos y ejecuta:"
  echo "   git add README.md install.sh"
  echo "   git rebase --continue"
  exit 1
fi

echo "🚀 Publica la rama actualizada:"
echo "   git push --force-with-lease"
