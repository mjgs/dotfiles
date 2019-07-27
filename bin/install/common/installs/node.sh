#!/bin/sh

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
BASH_PROFILE=$HOME/.bash_profile

function installNvm() {
  mkdir -p $HOME/.nvm
  touch $BASH_PROFILE

  if [ ! -x $HOME/.nvm/nvm.sh ]; then
    echo "$PFX Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  fi

  # reload nvm into this environment
  source $HOME/.nvm/nvm.sh
}

function installLatestStableNode() {
  echo "$PFX Installing latest stable node..."	
  
  nvm install stable
  nvm alias default stable

  echo "$PFX Current node: `which node`"
}

function installNodeModules() {
  echo "$PFX Installing node modules..."

  npm install -g browser-sync
  npm install -g express
  npm install -g express-generator
  npm install -g jshint
  npm install -g live-server
  npm install -g mocha
  npm install -g nodemon
}

#
# Main
#

installNvm
installLatestStableNode
installNodeModules

exit 0
