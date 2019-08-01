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

configureMongodb() {
  echo "$PFX Configuring mongodb..."

  if ! grep $HOME/.bash_profile mongodb-community; then
    echo 'export PATH="/usr/local/opt/mongodb-community@4.0/bin:$PATH"' >> $HOME/.bash_profile
  fi
}

function configureRedis() {
  echo "$PFX Configuring redis..."

  if which redis > /dev/null; then
    launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.redis.plist
  else
    echo "ERROR: redis must be installed"
    exit 1
  fi
}

#
# Main
#

configureMongodb
configureRedis

exit 0
