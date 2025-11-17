#!/bin/bash

# Dotfiles setup script
# This script creates symlinks from the home directory to dotfiles in ~/code/dotfiles

DOTFILES_DIR="$HOME/code/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Setting up dotfiles from $DOTFILES_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to create symlink with backup
create_symlink() {
  local source="$1"
  local target="$2"

  # If target exists and is not a symlink, back it up
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing $target to $BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
  fi

  # Remove existing symlink if it exists
  if [ -L "$target" ]; then
    rm "$target"
  fi

  # Create symlink
  echo "Creating symlink: $target -> $source"
  ln -s "$source" "$target"
}

# List of dotfiles to symlink
dotfiles=(
  ".gitconfig"
  ".gitignore_global"
  ".projections.json"
  ".tmux.conf"
  ".zshrc"
)

# Symlink each dotfile
for file in "${dotfiles[@]}"; do
  if [ -e "$DOTFILES_DIR/$file" ]; then
    create_symlink "$DOTFILES_DIR/$file" "$HOME/$file"
  else
    echo "Warning: $file not found in $DOTFILES_DIR"
  fi
done

# Symlink nvim config to ~/.config/nvim
mkdir -p "$HOME/.config"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Symlink zsh theme if oh-my-zsh is installed
if [ -d "$HOME/.oh-my-zsh/custom/themes" ]; then
  create_symlink "$DOTFILES_DIR/rickys.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/rickys.zsh-theme"
else
  echo "Oh-my-zsh not found, skipping zsh theme symlink"
fi

echo ""
echo "Dotfiles setup complete!"
echo "Backup of existing files (if any): $BACKUP_DIR"

# Remove backup directory if empty
if [ -z "$(ls -A "$BACKUP_DIR")" ]; then
  rmdir "$BACKUP_DIR"
  echo "No files were backed up."
fi
