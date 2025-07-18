#!/bin/bash

update_output() {
  window_title=$(timeout 0.5 hyprctl activewindow -j | jq -r '.title')

  rewritten_title=$(echo "$window_title" |
    sed 's/ — Zen Browser//' |
    sed 's/ — Ablaze Floorp//' |
    sed 's/ — Firefox Nightly//')

  mpris_title=$(timeout 0.5 playerctl metadata --format "{{ title }}" 2>/dev/null)

  if [ -n "$mpris_title" ] && [[ "$rewritten_title" == *"$mpris_title"* ]] || [[ "$rewritten_title" == "null" ]]; then
    echo "" # Output empty string to hide
  else
    max_length=80
    truncated_title=$(echo "$rewritten_title" | cut -c 1-$max_length)
    echo "$truncated_title" # Output the final title
  fi
}

# --- Event Handling Loop ---

# Find the Hyprland event socket dynamically using the correct file type 's' for socket.
HYPR_SOCKET=$(find /run/user/"$(id -u)"/hypr/ -type s -name ".socket2.sock" 2>/dev/null)

# Check if the socket was found. If not, exit gracefully.
if [ -z "$HYPR_SOCKET" ]; then
  echo "Error: Could not find Hyprland event socket." >&2
  exit 1
fi

# First, print the initial state so the bar isn't empty on startup
update_output

# This "while read" loop runs in the MAIN script process, avoiding subshell issues.
while read -r _event; do
  update_output
done < <(
  # This sub-process runs both listeners in the background.
  # stdbuf -oL is critical for disabling buffering so events are instant.
  stdbuf -oL socat -U - "$HYPR_SOCKET" &
  stdbuf -oL playerctl --follow metadata --format '{{ title }}' 2>/dev/null &
  wait
)
