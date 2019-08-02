#!/usr/bin/env bash

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
REPO_DIR=${REPO_DIR:?}
VSCODE_DOTFILES_DIR=$REPO_DIR/vscode
VSCODE_USER_SETTINGS_DIR="$HOME/Library/Application\ Support/Code/User"

echo "$PFX Configuring application: visual-studio-code"

mkdir -p "$VSCODE_DOTFILES_DIR"
mkdir -p "$VSCODE_USER_SETTINGS_DIR"

ln -sf "$VSCODE_DOTFILES_DIR"/settings.json "$VSCODE_USER_SETTINGS_DIR"/settings.json
ln -sf "$VSCODE_DOTFILES_DIR"/keybindings.json "$VSCODE_USER_SETTINGS_DIR"/keybindings.json
ln -sfn "$VSCODE_DOTFILES_DIR"/snippets "$VSCODE_USER_SETTINGS_DIR"/snippets

exit 0
