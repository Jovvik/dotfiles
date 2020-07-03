#!/usr/bin/env bash

killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload white &
  done
else
  MONITOR=HDMI-1-1 polybar --reload white &
fi