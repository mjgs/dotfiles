#!/bin/sh

#
# Description: installs brew packages
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
BASE_DIR=${BASE_DIR:?}
HOMEBREW_URL=https://raw.githubusercontent.com/Homebrew/install/master/install
PACKAGES=(
  ack
  cmake
  git
  git-extras
  mongodb-community@4.0
  httpie
  heroku
  iperf
  jq
  neovim
  nvm
  openssl
  redis
  tree
  watch
  wget
)

function installHomebrew() {
  echo "$PFX Installing homebrew..."

  if [ ! -x /usr/local/bin/brew ]; then
    echo "$PFX Homebrew url: $HOMEBREW_URL"
    ruby -e "$(curl -fsSL $HOMEBREW_URL)"
  else
    echo "$PFX Homebrew already installed, skipping..."
  fi
}

function addHomebrewTaps() {
  echo "$PFX Adding homebrew taps..."

  brew tap mongodb/brew
  brew tap heroku/brew
}

function installHomebrewPackages() {
  echo "$PFX Installing homebrew packages..."
 
  for PACKAGE in "${PACKAGES[@]}"; do
    echo "$PFX Installing package: $PACKAGE"
    brew install $PACKAGE
    configurePackage $PACKAGE
    echo "$PFX Install complete: $(date +"%Y-%m-%d-%H%M%S")"
  done
}

function configurePackage() {
  local PACKAGE=$1
 
  local CONFIGURATIONS_DIR=$BASE_DIR/bin/install/osx/configurations/cli 
  local CONFIGURATION_SCRIPT_NAME=$(echo $PACKAGE | cut -d@ -f1).sh
  local CONFIGURATION_SCRIPT=$CONFIGURATIONS_DIR/$CONFIGURATION_SCRIPT_NAME
  
  if [ -e $CONFIGURATION_SCRIPT ]; then
    $CONFIGURATION_SCRIPT
  else
    echo "$PFX No configuration script..."
  fi 
}

#
# Main
#

installHomebrew
addHomebrewTaps
installHomebrewPackages

exit 0
