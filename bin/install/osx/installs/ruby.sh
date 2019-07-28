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

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed"
  exit 1
fi

function installRuby() {
  echo "$PFX Installing ruby..."
  
  if [ ! -x /usr/local/bin/ruby ]; then
    echo "$PFX Installing ruby..."
    brew install ruby
  fi

  echo "$PFX Current ruby: `which ruby`"
  echo "$PFX Current rubygems: `which gem`"
}

function installRubyGems() {
  echo "$PFX Installing ruby gems..."
  gem install jekyll bundler
}

#
# Main
#

installRuby
installRubyGems

exit 0
