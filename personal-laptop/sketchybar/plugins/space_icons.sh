#!/usr/bin/env bash
# Refresh app icons shown in each workspace item

AEROSPACE=/opt/homebrew/bin/aerospace
source "$CONFIG_DIR/plugins/icon_map.sh"

args=()
for sid in $($AEROSPACE list-workspaces --all); do
  icons=""
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    __icon_map "$app"
    icons+="$icon_result "
  done < <($AEROSPACE list-windows --workspace "$sid" --format '%{app-name}' | sort -u)

  if [ -n "$icons" ]; then
    args+=(--set "space.$sid" label="${icons% }" label.drawing=on)
  else
    args+=(--set "space.$sid" label.drawing=off)
  fi
done

sketchybar "${args[@]}"
