#!/usr/bin/env bash

#
# Description: installs ruby and ruby modules
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
LANGUAGES_DIR=${LANGUAGES_DIR:-?}
LANGUAGES_RUBY_VERSION=${LANGUAGES_RUBY_VERSION:?}
DOWNLOAD_URL_BASE=${DOWNLOAD_URL_BASE:-https://cache.ruby-lang.org/pub/ruby}
OPENSSL_DIR=${OPENSSL_DIR:?}

CWD=$(pwd)
RUBY_DIR=$LANGUAGES_DIR/ruby
RUBY_NAME=ruby-$LANGUAGES_RUBY_VERSION
RUBY_MAJOR_VERSION=$(echo $LANGUAGES_RUBY_VERSION | sed 's/\.[^.]*$//')
DOWNLOAD_URL=$DOWNLOAD_URL_BASE/$RUBY_MAJOR_VERSION/$RUBY_NAME.tar.gz
DOWNLOAD_DIR=$RUBY_DIR/sources
INSTALL_DIR=$RUBY_DIR/versions/$RUBY_NAME

MODULES=(
  jekyll
)

function ensureOpensslDirectoryExists() {
  if [ ! -d "$OPENSSL_DIR" ]; then
    echo "ERROR: openssl directory does not exist: $OPENSSL_DIR, exiting..."
    exit 1
  fi
}

function downloadRuby() {
  echo "$PFX Creating ruby environment in directory: $RUBY_DIR"
  
  mkdir -p $RUBY_DIR/{sources,versions}
  
  echo "$PFX Downloading ruby from: $DOWNLOAD_URL"

  local DOWNLOAD_TARGET=$DOWNLOAD_DIR/$RUBY_NAME.tar.gz

  echo "$PFX Target: $DOWNLOAD_TARGET"
  
  if [ ! -e "$DOWNLOAD_TARGET" ]; then
    mkdir -p $DOWNLOAD_DIR
    wget $DOWNLOAD_URL -O $DOWNLOAD_TARGET || rm -f $DOWNLOAD_TARGET
  else
    echo "$PFX Download target already exists, skipping..."
  fi

  local UNTARED_TARGET=$(dirname $DOWNLOAD_TARGET)/$RUBY_NAME
  
  echo "$PFX Untaring archive: $DOWNLOAD_TARGET"

  # tar overwrites by default
  tar xvfz $DOWNLOAD_TARGET -C $DOWNLOAD_DIR
}

function installRuby() {
  cd $DOWNLOAD_DIR/$RUBY_NAME

  echo "$PFX Creating install directory: $INSTALL_DIR"
 
  mkdir -p $INSTALL_DIR

  echo "$PFX Setting compile variables: LDFLAGS CPPFLAGS PKG_CONFIG_PATH"

  export LDFLAGS=-L$OPENSSL_DIR/lib
  export CPPFLAGS=-I$OPENSSL_DIR/include
  export PKG_CONFIG_PATH=$OPENSSL_DIR/lib/pkgconfig

  local BUILT_FILE=$DOWNLOAD_DIR/.$RUBY_NAME
  
  if [ ! -e $BUILT_FILE ]; then
    echo "$PFX Configuring..."

    ./configure --prefix=$INSTALL_DIR

    echo "$PFX Making..."

    make

    echo "$PFX Installing..."

    make install

    echo "$PFX Creating build file: $BUILT_FILE"

    echo Built: $(date) > $BUILT_FILE
  fi

  cd $CWD
}

function installRubyModules() {
  echo "$PFX Installing ruby modules..."

  for MODULE in "${MODULES[@]}"; do
    echo "$PFX Installing ruby module: $MODULE"
    gem install $MODULE
  done
}

#
# Main
#

ensureOpensslDirectoryExists
downloadRuby
installRuby
installRubyModules

exit 0
