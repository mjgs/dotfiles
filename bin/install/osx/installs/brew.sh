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

  brew install ack
  brew install cmake
  brew install git
  brew install git-extras
  brew install heroku-toolbelt
  brew install httpie
  brew install iperf
  brew install jq
  brew install mongodb
  brew install neovim/neovim/neovim
  brew install nvm
  brew install openssl
  brew install redis
  brew install tree
  brew install watch
  brew install wget
  brew install youtube-dl
  brew install doctl
  brew install shellcheck
}

#
# Main
#

installHomebrew
installHomebrewPackages

exit 0
