#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Launch bar1 and bar2
polybar bar_left &
polybar bar_right &
polybar bar_center &
# polybar_wrapper bar2 &

echo "Bars launched..."
