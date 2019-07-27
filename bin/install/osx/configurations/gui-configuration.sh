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
DOTFILES_DIR=${DOTFILES_DIR:?}
HOME=${HOME:?}

#
# Main
#

function configureVscode() {
  echo "$PFX Configuring vscode user settings"
  
  ln -sf $DOTFILES_DIR/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
  ln -sf $DOTFILES_DIR/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
  ln -sfn $DOTFILES_DIR/vscode/snippets $HOME/Library/Application\ Support/Code/User/snippets
}

configureVscode
 
exit 0
