#!/usr/bin/env bash
# One-shot setup for the personal laptop: Ghostty + fish + tide, AeroSpace + SketchyBar, Raycast.
# Safe to re-run; existing configs are backed up to ~/.dotfiles-backup/<timestamp>/
# before being overwritten.
set -euo pipefail
cd "$(dirname "$0")"

# --- 1. Homebrew ---
if ! command -v brew >/dev/null; then
  echo "Homebrew not found — install it first: https://brew.sh" >&2
  exit 1
fi

# --- 2. Packages ---
brew install fish
brew install --cask ghostty raycast
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae
brew install sketchybar
brew install --cask font-sketchybar-app-font          # app icons in the bar
brew install --cask font-atkinson-hyperlegible-mono   # terminal font

# --- 3. Configs (back up anything already there) ---
# Every pre-existing config is copied into a timestamped folder before being
# replaced, so each run gets its own backup and originals are never clobbered.
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y-%m-%d_%H%M%S)"

backup_cp() { # backup_cp <src> <dest>
  if [ -e "$2" ]; then
    mkdir -p "$BACKUP_DIR"
    cp -r "$2" "$BACKUP_DIR/$(basename "$2")"
  fi
  mkdir -p "$(dirname "$2")"
  cp -r "$1" "$2"
}

backup_cp aerospace.toml   "$HOME/.aerospace.toml"
backup_cp ghostty/config   "$HOME/.config/ghostty/config"
backup_cp sketchybar       "$HOME/.config/sketchybar"
backup_cp fish/config.fish "$HOME/.config/fish/config.fish"
backup_cp fish/fish_plugins "$HOME/.config/fish/fish_plugins"
chmod +x "$HOME/.config/sketchybar/sketchybarrc" "$HOME/.config/sketchybar/plugins/"*.sh

# --- 4. fish plugins: fisher + tide prompt ---
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"

# --- 5. Start services ---
brew services restart sketchybar
open -a AeroSpace   # will ask for Accessibility permissions on first run

# --- 6. The bits that can't be scripted ---
[ -d "$BACKUP_DIR" ] && echo "Your previous configs were backed up to: $BACKUP_DIR"
cat <<'EOF'

Done. Manual steps left:
  1. Caps Lock -> Control:  System Settings > Keyboard > Keyboard Shortcuts...
     > Modifier Keys > Caps Lock = Control  (all the ctrl-keybinds assume this)
  2. Grant AeroSpace the Accessibility permission it just asked for.
  3. Hide the native menu bar:  System Settings > Control Center
     > "Automatically hide and show the menu bar" = Always.
  4. Run `tide configure` in a fish shell to pick your prompt style.
  5. Open Raycast once, set a hotkey, enable Clipboard History.

Keybinds and details: see QUICKSTART.md.
EOF
