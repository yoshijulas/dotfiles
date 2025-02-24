#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
  status="▶"
elif [ "$status" = "Paused" ]; then
  status=""
fi

playerctl metadata -f "$status  {{title}} - {{artist}} [{{duration(position)}}/{{duration(mpris:length)}}]"
