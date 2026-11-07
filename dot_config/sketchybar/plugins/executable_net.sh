#!/bin/bash
# Wi-Fi throughput every 2s. Graph = download on a log scale (so a quiet page load
# still shows, and a big download doesn't flatten everything). Label = ↓ speed;
# hover the graph to see ↑ too.
state=/tmp/sketchybar_net_${USER}
iface=$(route -n get default 2>/dev/null | awk '/interface:/{print $2}'); iface=${iface:-en0}

human() { awk -v b="$1" 'BEGIN{ if (b>=1048576) printf "%.1fM", b/1048576; else if (b>=1024) printf "%dK", b/1024; else printf "%dB", b }'; }

if [ "$SENDER" = "mouse.entered" ] || [ "$SENDER" = "mouse.exited" ]; then
  [ -f "$state.rate" ] || exit 0; read -r dn up < "$state.rate"
  if [ "$SENDER" = "mouse.entered" ]; then
    sketchybar --set net.label label.width=dynamic label="↓$(human "$dn") ↑$(human "$up")"
  else
    sketchybar --set net.label label.width=48 label="↓$(human "$dn")"
  fi
  exit 0
fi

read -r rx tx < <(netstat -ibn -I "$iface" | awk 'NR>1 && $7 ~ /^[0-9]+$/ {print $7, $10; exit}')
now=$(date +%s)
if [ -f "$state" ]; then
  read -r prx ptx pt < "$state"; dt=$((now - pt)); [ "$dt" -lt 1 ] && dt=1
  dn=$(( (rx - prx) / dt )); up=$(( (tx - ptx) / dt )); [ "$dn" -lt 0 ] && dn=0; [ "$up" -lt 0 ] && up=0
  echo "$dn $up" > "$state.rate"
  val=$(awk -v b="$dn" 'BEGIN{v=log(b+1)/log(52428800); if (v>1) v=1; printf "%.2f", v}')   # 50 MB/s = full
  sketchybar --push net.graph "$val" --set net.label label="↓$(human "$dn")"
fi
echo "$rx $tx $now" > "$state"
