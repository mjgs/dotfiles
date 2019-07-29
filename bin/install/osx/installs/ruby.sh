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
GEMS=(
  jekyll
  bundler
)

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed"
  exit 1
fi

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
    gem install $GEM
  done
}

#
# Main
#

installRuby
installRubyGems

exit 0
