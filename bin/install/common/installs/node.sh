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
LANGUAGES_DIR=${LANGUAGES_DIR:?}
LANGUAGES_NODE_VERSION=${LANGUAGES_NODE_VERSION:?}
DOWNLOAD_URL_BASE=${DOWNLOAD_URL_BASE:-https://nodejs.org/dist/}

CWD=$(pwd)
NODE_DIR=$LANGUAGES_DIR/node
NODE_NAME=node-v$LANGUAGES_NODE_VERSION
DOWNLOAD_URL=$DOWNLOAD_URL_BASE/v$LANGUAGES_NODE_VERSION/$NODE_NAME.tar.gz
DOWNLOAD_DIR=$NODE_DIR/sources
INSTALL_DIR=$NODE_DIR/versions/$NODE_NAME

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

function downloadNode() {
  echo "$PFX Creating node environment in directory: $NODE_DIR"
  
  mkdir -p $NODE_DIR/{sources,versions}
  
  echo "$PFX Downloading node from: $DOWNLOAD_URL"

  local DOWNLOAD_TARGET=$DOWNLOAD_DIR/$NODE_NAME.tar.gz

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

function installNode() {
  cd $DOWNLOAD_DIR/$NODE_NAME

  echo "$PFX Creating install directory: $INSTALL_DIR"

  mkdir -p $INSTALL_DIR

  local BUILT_FILE=$DOWNLOAD_DIR/.$PERL_NAME

  if [ ! -e $BUILT_FILE ]; then
    echo "$PFX Configuring..."

    ./configure --prefix=$INSTALL_DIR

    echo "$PFX Making..."

    make -j4

    echo "$PFX Testing..."

    make test-only

    echo "$PFX Installing into a system directory..."

    make install

    echo "$PFX Building docs..."

    make doc

    echo "$PFX Creating build file: $BUILT_FILE"

    echo Built: $(date) > $BUILT_FILE
  fi

  cd $CWD
}

#
# Main
#

downloadNode
installNode
installNodeModules

exit 0
