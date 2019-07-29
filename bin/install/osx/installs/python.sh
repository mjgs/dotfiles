#!/bin/sh

#
# Description: installs python and python packages
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
PACKAGES=(
  neovim
)

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed"
  exit 1
fi

function installPython() {
  echo "$PFX Installing python..."
  
  if [ ! -x /usr/local/bin/python ]; then	
    brew install python --framework --with-brewed-openssl
  else
    echo "$PFX Python already installed, skipping..."
  fi

  echo "Current python: $(which python)"
  echo "Current python version: $(python --version)"
}

function installPythonPackages() {
  echo "$PFX Installing python packages..."

  for PACKAGE in "${PACKAGES[@]}"; do
    echo "$PFX Installing python package: $PACKAGE"
    pip2 install --user $PACKAGE
  done
}

#
# Main
#

installPython
installPythonPackages

exit 0
