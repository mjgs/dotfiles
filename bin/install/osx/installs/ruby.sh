#!/bin/sh

#
# Description: installs ruby and ruby packages
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
GEMS=(
#  jekyll
)

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed"
  exit 1
fi

function installOpenssl() {
  echo "$PFX Installing openssl..."
  brew install openssl
  echo "$PFX Current openssl: $(which openssl)"
  echo "$PFX Current openssl version: $(openssl version)"
}

function installRuby() {
  echo "$PFX Installing ruby..."
  
  if [ ! -x /usr/local/bin/ruby ]; then
    brew install ruby
  else
    echo "$PFX Ruby already installed, skipping..."
  fi

  echo "$PFX Current ruby: $(which ruby)"
  echo "$PFX Current ruby version: $(ruby --version)"
  echo "$PFX Current rubygems: $(which gem)"
}

function installRubyGems() {
  echo "$PFX Installing ruby gems..."

  for GEM in "${GEMS[@]}"; do
    echo "$PFX Installing gem: $GEM"
    gem install --source https://rubygems.org $GEM
  done
}

#
# Main
#

installOpenssl
installRuby
installRubyGems

exit 0
