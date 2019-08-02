#!/usr/bin/env bash

#
# Description: installs node and node modules
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
NVM_VERSION=${NVM_VERSION:-v0.34.0}
MODULES=(
  browser-sync
  express
  express-generator
  jshint
  live-server
  mocha
  nodemon
)

function installNvm() {
  local NVM_URL=https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh

  echo "$PFX Installing nvm..."
 
  if [ ! -d $HOME/.nvm ]; then
    echo "$PFX Nvm install url: $NVM_URL"
    cd $HOME
    curl -o- $NVM_URL | bash
  else
    echo "$PFX nvm directory $HOME/.nvm exists, skipping..."
  fi
 
  # Load nvm into current environment 
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

function installLatestNode() {
  # Nvm installs currently silently crash the script unless exit on error is turned off
  # TODO - Figure out why it's necessary to turn off exit on error https://github.com/nvm-sh/nvm/issues/2080
  set +e
  nvm install stable
  set -e
}

function installNodeModules() {
  echo "$PFX Installing node modules..."

  for MODULE in "${MODULES[@]}"; do
    echo "$PFX Installing node module: $MODULE"
    npm install -g $MODULE
  done
}

#
# Main
#

installNvm
installLatestNode
installNodeModules

exit 0
