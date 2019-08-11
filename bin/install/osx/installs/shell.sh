#!/bin/sh

#
# Description: installs shell
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

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed" 
  exit 1
fi

installLatestBash() {
  echo "$PFX Installing latest bash version..."
  
  if [ ! -x /usr/local/bin/bash ]; then
    brew install bash

    echo "$PFX Adding /usr/local/bin/bash to /etc/shells..."
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'

    echo "$PFX Setting shell to /usr/local/bin/bash..."
    chsh -s /usr/local/bin/bash
  else
    echo "$PFX Lastest bash already installed, skipping..."
  fi

  echo "$PFX Current bash: $(which bash)"
  echo "$PFX Current bash version: $(bash --version)"
}

#
# Main
#

installLatestBash

exit 0
