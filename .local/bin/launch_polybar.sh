#!/usr/bin/env sh

killall -q polybar

if type "xrandr" >/dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload white &
  done
else
  MONITOR=HDMI-1-1 polybar --reload white &
fi
