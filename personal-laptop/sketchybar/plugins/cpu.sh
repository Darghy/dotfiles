#!/usr/bin/env bash
# CPU: total usage percent (normalized to core count)

CORES="$(sysctl -n hw.ncpu)"
TOTAL="$(ps -A -o %cpu | awk '{s+=$1} END {print s}')"
PCT="$(awk -v t="$TOTAL" -v c="$CORES" 'BEGIN {printf "%d", t/c}')"

COLOR=0xffcdd6f4
[ "$PCT" -ge 70 ] && COLOR=0xfff38ba8

sketchybar --set "$NAME" icon="􀧓" label="${PCT}%" label.color="$COLOR"
