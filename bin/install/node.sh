#!/bin/sh
#
# Description: installs node and node modules

if [ ! -x /usr/local/bin/brew ]; then
	echo "ERROR: Homebrew must be installed to run the node.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/opt/nvm/nvm.sh ]; then
  echo "Installing nvm..."
  brew install nvm
  if [ ! -e $HOME/.nvm ]; then 
  	mkdir $HOME/.nvm; 
  fi 
fi

# reload nvm into this environment
source $(brew --prefix nvm)/nvm.sh

echo "Installing latest stable node..."	
nvm install stable
nvm alias default stable

echo "Current node: `which node`"

echo "Installing node modules..."
npm install -g bower
npm install -g express
npm install -g gulp
npm install -g grunt
npm install -g istanbul
npm install -g jshint
npm install -g live-server
npm install -g mocha
npm install -g mocha-phantomjs
npm install -g nodemon
npm install -g offline-docs
npm install -g phantomjs
npm install -g private-bower
npm install -g sinopia
npm install -g watchify

if [ -x $CONFIGS_DIR/node_local.sh ]; then
  $CONFIGS_DIR/node_local.sh			
fi

exit 0