#!/bin/sh
#
# Description: installs node and node modules

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
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
  if [ ! -e $HOME/.nvm ]; then 
    mkdir $HOME/.nvm; 
  fi 
fi

# reload nvm into this environment
source ~/.nvm/nvm.sh

echo "Installing latest stable node..."	
nvm install stable
nvm alias default stable

echo "Current node: `which node`"

echo "Installing node modules..."
npm install -g bower
npm install -g browser-sync
npm install -g express
npm install -g express-generator
npm install -g gulp
npm install -g grunt
npm install -g istanbul
npm install -g jshint
npm install -g live-server
npm install -g mocha
npm install -g nodemon

if [ -x $CONFIGS_DIR/node_local.sh ]; then
  $CONFIGS_DIR/node_local.sh			
fi

exit 0
