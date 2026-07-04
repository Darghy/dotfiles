#!/usr/bin/env bash
# Battery: 5-level SF Symbol icon, charging bolt, colored by level

BATT_INFO="$(pmset -g batt)"
PERCENTAGE="$(echo "$BATT_INFO" | grep -Eo '[0-9]+%' | cut -d% -f1)"
CHARGING="$(echo "$BATT_INFO" | grep 'AC Power')"

[ -z "$PERCENTAGE" ] && exit 0

COLOR=0xffcdd6f4
case "$PERCENTAGE" in
  100|9[0-9]|8[0-9]) ICON="􀛨" ;;
  [6-7][0-9])        ICON="􀺸" ;;
  [4-5][0-9])        ICON="􀺶" ;;
  [2-3][0-9])        ICON="􀛩" COLOR=0xfffab387 ;;
  *)                 ICON="􀛪" COLOR=0xfff38ba8 ;;
esac

if [ -n "$CHARGING" ]; then
  ICON="􀢋"
  COLOR=0xffa6e3a1
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
