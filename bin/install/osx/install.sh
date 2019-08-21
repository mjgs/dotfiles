#!/usr/bin/env bash

#
# Description: installs osx items 
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
DOTFILES_DIR=${DOTFILES_DIR:?}
HOMEBREW_URL=${HOMEBREW_URL:?}

if [ ! -x /usr/bin/gcc ]; then
  echo "$PFX Installing xcode..."
  xcode-select --install
fi

function installHomebrew() {
  echo "$PFX Installing homebrew..."

  if [ ! -x /usr/local/bin/brew ]; then
    echo "$PFX Homebrew url: $HOMEBREW_URL"
    ruby -e "$(curl -fsSL $HOMEBREW_URL)"
  else
    echo "$PFX Homebrew already installed, skipping..."
  fi
}

installHomebrew

echo "$PFX Installing OSX items"

$DOTFILES_DIR/bin/install/osx/installs/shell.sh
$DOTFILES_DIR/bin/install/osx/installs/brew.sh
$DOTFILES_DIR/bin/install/osx/installs/gui.sh

echo "$PFX Configuring OSX settings and applications"

$DOTFILES_DIR/bin/install/osx/configurations/system/set_system_prefs.sh
$DOTFILES_DIR/bin/install/osx/configurations/system/set_hidden_prefs.sh
$DOTFILES_DIR/bin/install/osx/configurations/system/set_application_prefs.sh
$DOTFILES_DIR/bin/install/osx/configurations/system/configure_dock_apps.sh

exit 0
