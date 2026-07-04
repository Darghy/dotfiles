#!/usr/bin/env bash
# Highlight the focused AeroSpace workspace

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on icon.color=0xff89b4fa label.color=0xff89b4fa
else
  sketchybar --set "$NAME" background.drawing=off icon.color=0xffcdd6f4 label.color=0xffcdd6f4
fi
