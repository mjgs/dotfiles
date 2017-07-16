#!/bin/sh
#
# Description: installs python and python packages

if [ ! $CONFIGS_DIR ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the python.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/bin/python ]; then	
  echo "Installing python..."
  brew install python --framework --with-brewed-openssl
fi

echo "Current python: `which python`"

echo "Installing python packages..."
pip2 install --user neovim
pip install beets
pip install haxor-news

if [ -x $CONFIGS_DIR/python_local.sh ]; then
  $CONFIGS_DIR/python_local.sh			
fi

exit 0
