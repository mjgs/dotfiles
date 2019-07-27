#!/bin/sh

#
# Description: configures osx cli utilities
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

function configureRedis() {
  if which redis > /dev/null; then
    echo "$PFX Configuring redis..."
    launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.redis.plist
  else
    echo "ERROR: redis must be installed"
    exit 1
  fi
}

#
# Main
#

configureRedis

exit 0
