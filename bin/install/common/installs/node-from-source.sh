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
HOME=${HOME:?}
NODE_ROOT=${NODE_ROOT:-$HOME/.node}
NODE_URL_BASE=${NODE_URL_BASE:-https://nodejs.org/download/release}
NODE_VERSION=${NODE_VERSION:?}
MODULES=(
  browser-sync
  express
  express-generator
  jshint
  live-server
  mocha
  nodemon
  npm-check-updates
  npm-check
)

CWD=$(pwd)
NODE_NAME=node-$NODE_VERSION
DOWNLOAD_URL=$NODE_URL_BASE/$NODE_NAME.tar.gz
DOWNLOAD_DIR=$NODE_ROOT/sources
INSTALL_DIR=$NODE_ROOT/versions/$NODE_NAME

function downloadNode() {
  echo "$PFX Downloading node..."

  createNodeDirecotries
  
  echo "$PFX Downloading node from: $DOWNLOAD_URL"

  local DONWLOAD_TARGET=$DOWNLOAD_DIR/$NODE_NAME.tar.gz

  echo "$PFX Target: $DOWNLOAD_TARGET"

  if [ ! -e "$DOWNLOAD_TARGET" ]; then
    mkdir -p $DOWNLOAD_DIR
    wget $DOWNLOAD_URL -O $DOWNLOAD_TARGET || rm -f $DOWNLOAD_TARGET
  else
    echo "$PFX Download target already exists, skipping..."
  fi

  local UNTARED_TARGET=$(dirname $DOWNLOAD_TARGET)/$NODE_NAME
  
  echo "$PFX Untaring archive: $DOWNLOAD_TARGET"

  # tar overwrites by default
  tar xvfz $DOWNLOAD_TARGET -C $DOWNLOAD_DIR
}

function createNodeDirectories() {
  echo "$PFX Creating node directories in: $NODE_ROOT"

  mkdir -p $NODE_ROOT/{sources,versions}
}

function verifyNodeDownload() {
  echo "$PFX Verifying node download..."

  gpg --keyserver pool.sks-keyservers.net --recv-keys 4ED778F539E3634C779C87C6D7062848A1AB005C
  gpg --keyserver pool.sks-keyservers.net --recv-keys B9E2F5981AA6E0CD28160D9FF13993A75599653C
  gpg --keyserver pool.sks-keyservers.net --recv-keys 94AE36675C464D64BAFA68DD7434390BDBE9B9C5
  gpg --keyserver pool.sks-keyservers.net --recv-keys B9AE9905FFD7803F25714661B63B535A4C206CA9
  gpg --keyserver pool.sks-keyservers.net --recv-keys 77984A986EBC2AA786BC0F66B01FBB92821C587A
  gpg --keyserver pool.sks-keyservers.net --recv-keys 71DCFD284A79C3B38668286BC97EC7A07EDE3FC1
  gpg --keyserver pool.sks-keyservers.net --recv-keys FD3A5288F042B6850C66B31F09FE44734EB7990E
  gpg --keyserver pool.sks-keyservers.net --recv-keys 8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600
  gpg --keyserver pool.sks-keyservers.net --recv-keys C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8
  gpg --keyserver pool.sks-keyservers.net --recv-keys DD8F2338BAE7501E3DD5AC78C273792F7D83545D
  gpg --keyserver pool.sks-keyservers.net --recv-keys A48C2BEE680E841632CD4E44F07496B3EB3C1762
}

function installNode() {
  echo "$PFX Installing node..."
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

downloadNode
verifyNodeDownload
installNode
installNodeModules

exit 0
