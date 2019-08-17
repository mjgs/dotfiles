#!/usr/bin/env bash

#
# Description: installs openssl
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
OS_TYPE=${OS_TYPE:?}

function installPreparation() {
  if [ "$OS_TYPE" = "osx" ]; then
    echo "$PFX Installing homebrew..."

    local HOMEBREW_URL=${HOMEBREW_URL:?}

    if [ ! -x /usr/local/bin/brew ]; then
      echo "$PFX Homebrew url: $HOMEBREW_URL"
      ruby -e "$(curl -fsSL $HOMEBREW_URL)"
    else
      echo "$PFX Homebrew already installed, skipping..."
    fi
  fi
}

function installOpenssl() {
  if [ "$OS_TYPE" = "osx" ]; then
    echo "$PFX Installing package: openssl"
    brew install openssl
  fi
}

#
# Main
#

installPreparation
installOpenssl

exit 0
