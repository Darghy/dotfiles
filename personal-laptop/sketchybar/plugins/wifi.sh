#!/usr/bin/env bash
# Wi-Fi: icon-only (macOS redacts SSID from CLI without Location Services)

IP="$(ipconfig getifaddr en0 2>/dev/null)"

if [ -n "$IP" ]; then
  sketchybar --set "$NAME" icon="􀙇" icon.color=0xff89b4fa
else
  sketchybar --set "$NAME" icon="􀙈" icon.color=0xff6c7086
fi
