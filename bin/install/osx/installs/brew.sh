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
   heroku-toolbelt
   httpie
   iperf
   jq
   mongodb
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
    echo "$PFX Installing homebrew...
    echo "$PFX Homebrew url: $HOMEBREW_URL""
    
    ruby -e "$(curl -fsSL $HOMEBREW_URL)" 
  fi
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
installHomebrewPackages

exit 0
