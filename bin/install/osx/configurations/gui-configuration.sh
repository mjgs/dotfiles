#!/usr/bin/env bash

#
# Description: configures installed gui apps
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
REPO_DIR=${REPO_DIR:?}
HOME=${HOME:?}
VSCODE_DOTFILES_DIR=$REPO_DIR/vscode
VSCODE_USER_SETTINGS_DIR="$HOME/Library/Application\ Support/Code/User"

#
# Main
#

function configureVscode() {
  echo "$PFX Configuring vscode user settings"
  
  ln -sf $VSCODE_DOTFILES_DIR/settings.json $VSCODE_USER_SETTINGS_DIR/settings.json
  ln -sf $VSCODE_DOTFILES_DIR/keybindings.json $VSCODE_USER_SETTINGS_DIR/keybindings.json
  ln -sfn $VSCODE_DOTFILES_DIR/snippets $VSCODE_USER_SETTINGS_DIR/Code/User/snippets
}

configureVscode
 
exit 0
