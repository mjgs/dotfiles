#!/bin/sh
#
# Description: installs node and node modules

BASH_PROFILE=$HOME/.bash_profile

if [ ! $CONFIGS_DIR ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the node.sh installer script"
  exit 1
fi

if [ ! -x ~/.nvm/nvm.sh ]; then
  echo "Installing nvm..."
  if [ ! -f $BASH_PROFILE ]; then
    touch $BASH_PROFILE
  fi
  if [ ! -e $HOME/.nvm ]; then 
    mkdir $HOME/.nvm; 
  fi 
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
fi

# reload nvm into this environment
source $HOME/.nvm/nvm.sh

echo "Installing latest stable node..."	
nvm install stable
nvm alias default stable

echo "Current node: `which node`"

echo "Installing node modules..."
npm install -g browser-sync
npm install -g express
npm install -g express-generator
npm install -g jshint
npm install -g live-server
npm install -g mocha
npm install -g nodemon

if [ -x $CONFIGS_DIR/node_local.sh ]; then
  $CONFIGS_DIR/node_local.sh			
fi

exit 0
