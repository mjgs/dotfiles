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
BASH_PROFILE=$HOME/.bash_profile

function installNvm() {
  echo "$PFX Installing nvm..."
  
  if [ ! -d $HOME/.nvm ]; then
    touch $BASH_PROFILE
    export NVM_DIR="$HOME/.nvm" && (
      git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
      cd "$NVM_DIR"
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"i
  else
    echo "$PFX nvm directory $HOME/.nvm exists, skipping..."
  fi
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
