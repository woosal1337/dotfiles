#!/bin/bash
# Rift workspaces → bar. Current: white number + peach underline. Has windows: grey.
# Empty: hidden. Label shows an icon per app on that workspace (sketchybar-app-font).
# Triggered by Rift (workspace/window changes) via the subscriptions in rift's run_on_start.
source "$HOME/.config/sketchybar/plugins/icon_map.sh"
json=$(rift-cli query workspaces 2>/dev/null) || exit 0
args=()
while IFS=$'\t' read -r idx active count apps; do
  n=$((idx + 1)); icons=""
  IFS='|' read -ra list <<<"$apps"
  for app in "${list[@]}"; do
    [ -z "$app" ] && continue
    case "$app" in Yab) icon_result=":arc:" ;; *) __icon_map "$app" ;; esac
    icons+="$icon_result "
  done
  icons="${icons% }"
  if [ "$active" = "true" ]; then
    args+=(--set space.$n drawing=on icon.color=0xffffffff label="$icons" label.drawing=$([ -n "$icons" ] && echo on || echo off) background.drawing=on)
  elif [ "$count" -gt 0 ]; then
    args+=(--set space.$n drawing=on icon.color=0xffa0a0a0 label="$icons" label.drawing=on background.drawing=off)
  else
    args+=(--set space.$n drawing=off)
  fi
done < <(jq -r '.[] | [.index, .is_active, .window_count, ([.windows[].app_name] | unique | join("|"))] | @tsv' <<<"$json")
sketchybar "${args[@]}"
