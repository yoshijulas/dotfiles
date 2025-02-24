#!/bin/bash

# Get the current position and the total length of the song
read -r position length < <(playerctl metadata -f "{{position}} {{mpris:length}}" 2>/dev/null)

# Check if position and length were successfully retrieved and are not zero
if [ -n "$position" ] && [ -n "$length" ] && [ "$length" -gt 0 ]; then

  # Convert position and length to numbers (remove any non-numeric characters and leading zeros)
  position_num=$(printf '%d' "$position")
  length_num=$(printf '%d' "$length")

  # Calculate progress percentage
  progress_percent=$(((position_num * 100) / length_num))

  # Calculate number of steps to fill in the progress bar (out of 10)
  progress_steps=$(((progress_percent * 20) / 100))

  # Create progress bar string
  progress_bar=""
  for ((i = 1; i <= 20; i++)); do
    if [ "$i" -le "$progress_steps" ]; then
      progress_bar+=""
    else
      progress_bar+="─"
    fi
  done

  # Output the progress bar
  echo "${progress_bar}"
fi
