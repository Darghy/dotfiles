# Artur's macOS setup — install guide

Terminal: **Ghostty + fish + tide**. Tiling: **AeroSpace + SketchyBar**. Plus **Raycast**.

> TL;DR: `./install.sh` does steps 1–3 and 5 automatically. Below is the
> same thing done by hand, plus explanations and the keybinds.

## 1. Install everything (via Homebrew)

```sh
# if you don't have brew: https://brew.sh
brew install --cask ghostty raycast
brew install fish
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae && brew install sketchybar
brew install --cask font-sketchybar-app-font   # icons for SketchyBar
```

The terminal font is "Atkinson Hyperlegible Mono" (use whatever you like, but if you want the same):

```sh
brew install --cask font-atkinson-hyperlegible-mono
```

## 2. Put the files in the right places

```sh
cp aerospace.toml ~/.aerospace.toml
mkdir -p ~/.config/ghostty && cp ghostty/config ~/.config/ghostty/config
cp -r sketchybar ~/.config/sketchybar
chmod +x ~/.config/sketchybar/sketchybarrc ~/.config/sketchybar/plugins/*.sh
mkdir -p ~/.config/fish && cp fish/config.fish fish/fish_plugins ~/.config/fish/
```

## 3. fish + tide

```sh
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"
fish -c "set -U tide_left_prompt_items pwd git newline character; set -U tide_right_prompt_items"
```

The Tide prompt shows only the current folder and Git status.

The Ghostty config launches fish itself (`command = /opt/homebrew/bin/fish`),
so you don't need to change your login shell.

## 4. Caps Lock → Control

System Settings → Keyboard → Keyboard Shortcuts… → Modifier Keys →
Caps Lock = Control. (All the ctrl keybinds below assume this — caps lock
is a much more comfortable key to press.)

## 5. Launch

```sh
open -a AeroSpace     # asks for Accessibility permissions — grant them
brew services start sketchybar
```

After that, AeroSpace starts SketchyBar itself (`after-startup-command` in
the config) and both start automatically at login from then on.

Hide Apple's own menu bar: System Settings → Control Center →
"Automatically hide and show the menu bar" = Always. (Otherwise you get two bars.)

## Keybinds (cheat sheet)

| Key | What it does |
|---|---|
| `ctrl + 1…0` | go to workspace 1–10 |
| `ctrl + shift + 1…0` | move the active window to workspace N (and follow it) |
| `ctrl + i / j / k / l` | focus up / left / down / right |
| `ctrl + shift + i/j/k/l` | move the window within the workspace |
| `ctrl + shift + f` | fullscreen |
| `ctrl + h` | focus the next monitor |

## Fair warning

AeroSpace is not beginner-friendly — it takes ~20 min of active fiddling to
get used to. All the bindings are in `~/.aerospace.toml` (the
[mode.main.binding] section) and they're easy to change; the config
auto-reloads on save.

SketchyBar's `icon_map.sh` is a standard community script
(sketchybar-app-font) — you don't need to read or modify it.

## Raycast + Trimmy

In Raycast Settings, set the main hotkey to `⌘ Space` so Raycast replaces
Spotlight. Under Extensions → Clipboard History, set the hotkey to `⌥ V` so
clipboard history sits next to regular paste (`⌘ V`).

[Trimmy](https://github.com/steipete/Trimmy) flattens copied multi-line shell
commands so they paste and run once:

```sh
brew install --cask steipete/tap/trimmy
open -a Trimmy
```
