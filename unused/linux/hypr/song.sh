#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
  status="▶"
elif [ "$status" = "Paused" ]; then
  status=""
fi

duration=$(playerctl metadata -f "{{duration(position)}}" 2>/dev/null)

if [ "$duration" = "0:00" ]; then
  duration=""
else
  duration=$(playerctl metadata -f "[{{duration(position)}}/{{duration(mpris:length)}}]" 2>/dev/null)
fi

playerctl metadata -f "$status  {{title}} - {{artist}} $duration"
