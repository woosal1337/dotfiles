#!/bin/bash
# Name of the focused app (lower-case to match the rest of the bar)
[ "$SENDER" = "front_app_switched" ] && sketchybar --set "$NAME" label="$(tr '[:upper:]' '[:lower:]' <<<"$INFO")"
