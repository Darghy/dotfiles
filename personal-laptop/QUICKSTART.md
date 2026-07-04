# Arturi macOS setup — paigaldusjuhend

Terminal: **Ghostty + fish + tide**. Tiling: **AeroSpace + SketchyBar**. Pluss **Raycast**.

> TL;DR: `./install.sh` teeb sammud 1–3 ja 5 automaatselt ära. Allpool on
> sama asi käsitsi + selgitused ja kiirklahvid.

## 1. Installi kõik (Homebrew kaudu)

```sh
# kui brew't pole: https://brew.sh
brew install --cask ghostty raycast
brew install fish
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae && brew install sketchybar
brew install --cask font-sketchybar-app-font   # ikoonid SketchyBari jaoks
```

Font terminalis on "Atkinson Hyperlegible Mono" (vabalt valitav, aga kui tahad sama):

```sh
brew install --cask font-atkinson-hyperlegible-mono
```

## 2. Failid õigetesse kohtadesse

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
fish -c "tide configure"   # interaktiivne prompt-seadistaja, vali mis meeldib
```

Ghostty config käivitab fish'i ise (`command = /opt/homebrew/bin/fish`), nii et
login-shelli ei pea vahetama.

## 4. Caps Lock → Control

System Settings → Keyboard → Keyboard Shortcuts… → Modifier Keys →
Caps Lock = Control. (Kõik ctrl-kiirklahvid allpool eeldavad seda — caps lock
on palju mugavam vajutada.)

## 5. Käivita

```sh
open -a AeroSpace     # küsib Accessibility õigusi — luba need
brew services start sketchybar
```

AeroSpace käivitab pärast seda SketchyBari ise (`after-startup-command` configis)
ja mõlemad käivituvad edaspidi loginil automaatselt.

Peida Apple'i enda menüüriba: System Settings → Control Center →
"Automatically hide and show the menu bar" = Always. (Muidu on kaks riba.)

## Kiirklahvid (cheat sheet)

| Klahv | Mida teeb |
|---|---|
| `ctrl + 1…0` | mine workspace'ile 1–10 |
| `ctrl + shift + 1…0` | vii aktiivne aken workspace'ile N (ja mine kaasa) |
| `ctrl + i / j / k / l` | fookus üles / vasakule / alla / paremale |
| `ctrl + shift + i/j/k/l` | liiguta akent samas workspace'is |
| `ctrl + shift + f` | fullscreen |
| `ctrl + h` | fookus järgmisele monitorile |

## Fair warning

AeroSpace ei ole algajasõbralik — võtab ~20 min aktiivset proovimist, et
harjuda. Kõik binding'ud on failis `~/.aerospace.toml` ([mode.main.binding]
sektsioon) ja neid on lihtne ümber teha; config laeb salvestamisel ise uuesti.

SketchyBari `icon_map.sh` on standardne community-skript
(sketchybar-app-font) — seda ei pea lugema ega muutma.

Raycast: ava see, ja Settings → Extensions → Clipboard History pane
kiirklahvi taha. Juba ainuüksi selle pärast tasub.
