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
HOMEBREW_URL=https://raw.githubusercontent.com/Homebrew/install/master/install
PACKAGES=(
   ack
   cmake
   git
   git-extras
   mongodb-community@4.0
   httpie
   iperf
   jq
   neovim/neovim/neovim
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
}

function installHomebrewPackages() {
  echo "$PFX Installing homebrew packages..."
 
  for PACKAGE in "${PACKAGES[@]}"; do
    echo "$PFX installing brew package: $PACKAGE"
    brew install $PACKAGE
  done
}

#
# Main
#

installHomebrew
addHomebrewTaps
installHomebrewPackages

exit 0
