#!/bin/bash
# Battery %: "+" while charging, red under 20%
info=$(pmset -g batt)
pct=$(grep -Eo '[0-9]+%' <<<"$info" | head -1 | tr -d '%')
[ -z "$pct" ] && exit 0
label="$pct%"; color=0xffffffff
grep -q 'AC Power' <<<"$info" && label="+$pct%"
[ "$pct" -lt 20 ] && ! grep -q 'AC Power' <<<"$info" && color=0xffff8080
sketchybar --set "$NAME" label="$label" label.color=$color
