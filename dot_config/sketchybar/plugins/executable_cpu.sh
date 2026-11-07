#!/bin/bash
# Total CPU use across all cores, every 2s → graph (0..1) + percentage label
cores=$(sysctl -n hw.ncpu)
pct=$(ps -A -o %cpu= | awk -v c="$cores" '{s+=$1} END {v=s/c; if (v>100) v=100; printf "%d", v}')
sketchybar --push cpu.graph "$(awk -v p="$pct" 'BEGIN{printf "%.2f", p/100}')" \
           --set cpu.label label="$pct%"
