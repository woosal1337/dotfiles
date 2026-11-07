#!/bin/bash
# e.g. "wed 5 nov  13:42"
sketchybar --set "$NAME" label="$(date '+%a %-d %b  %H:%M' | tr '[:upper:]' '[:lower:]')"
