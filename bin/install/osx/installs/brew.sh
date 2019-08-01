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
    echo "$PFX installing brew package: $PACKAGE"
    brew install $PACKAGE
  done
}

configureMongodb() {
  echo "$PFX Configuring mongodb..."

  if ! grep mongodb-community $HOME/.bash_profile; then
    echo 'export PATH="/usr/local/opt/mongodb-community@4.0/bin:$PATH"' >> $HOME/.bash_profile
  fi
}

function configureRedis() {
  echo "$PFX Configuring redis..."

  if which redis-server > /dev/null; then
    launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.redis.plist
  else
    echo "ERROR: redis must be installed"
    exit 1
  fi
}

function configureOpenssl() {
  echo "$PFX Configuring openssl..."

  echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> $HOME/.bash_profile
}

function configurePackages() {
  configureMongodb
  configureRedis
  configureOpenssl
}

#
# Main
#

installHomebrew
addHomebrewTaps
installHomebrewPackages
configurePackages

exit 0
