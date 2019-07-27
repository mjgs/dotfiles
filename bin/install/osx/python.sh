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
CONFIGS_DIR=${CONFIGS_DIR:?}

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the python.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/bin/python ]; then	
  echo "$PFX Installing python..."
  brew install python --framework --with-brewed-openssl
fi

echo "Current python: `which python`"

echo "$PFX Installing python packages..."
pip2 install --user neovim

if [ -x $CONFIGS_DIR/python_local.sh ]; then
  $CONFIGS_DIR/python_local.sh			
fi

exit 0
