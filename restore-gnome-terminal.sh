#!/bin/bash

# Restore GNOME Terminal profiles from dconf dump

DOTFILES_DIR="$HOME/code/dotfiles"
PROFILE_FILE="$DOTFILES_DIR/gnome-terminal-profiles.dconf"

if [ ! -f "$PROFILE_FILE" ]; then
  echo "Error: Profile file not found at $PROFILE_FILE"
  exit 1
fi

echo "Restoring GNOME Terminal profiles..."
dconf load /org/gnome/terminal/legacy/profiles:/ < "$PROFILE_FILE"

echo "GNOME Terminal profiles restored successfully!"
echo "You may need to restart GNOME Terminal to see the changes."
