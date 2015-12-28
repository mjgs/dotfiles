#!/bin/sh
#
# Description: Installs fresh Mac OSX environment
#
# Usage: 
# export CONFIGS_DIR=/path/to/dir (optional)
# export CODES_DIR=/path/to/dir (optional)
# install.sh

CURRENT_DIR=`pwd`

if [ ! $CONFIGS_DIR ]; then 
  CONFIGS_DIR=$CURRENT_DIR/Configs
fi		

export CONFIGS_DIR=$CONFIGS_DIR
echo "CONFIGS_DIR: $CONFIGS_DIR"

if [ ! $CODES_DIR ]; then 
  CODES_DIR=$CURRENT_DIR/Codes
fi	

if [ ! -e $CODES_DIR ]; then 
  echo "Creating codes directory: $CODES_DIR"
  mkdir $CODES_DIR
fi	

echo "Creating convenience symlink from $HOME/codes to $CODES_DIR"
if [ ! -L $HOME/codes ]; then 
	ln -s $CODES_DIR $HOME/codes; 
fi

export CODES_DIR=$CODES_DIR
echo "CODES_DIR: $CODES_DIR"

echo "########################################################################"
echo "#                      Installing cli tools [1/4]                      #"
echo "########################################################################"

if [ ! -x /usr/bin/gcc ]
then
  echo "Installing xcode..."
  xcode-select --install
fi

if [ ! -x /usr/bin/git ]
then
	echo "ERROR: Apple's version of git must be installed to run the install.sh installer script"
  exit 1
fi

echo "Cloning dotfiles repo..."
DOTFILES_DIR=$CONFIGS_DIR/dotfiles
git clone http://github.com/mjgs/dotfiles.git $DOTFILES_DIR 

echo "Running install scripts..."
$DOTFILES_DIR/bin/install/dotfiles.sh
$DOTFILES_DIR/bin/install/brew.sh
$DOTFILES_DIR/bin/install/ruby.sh
$DOTFILES_DIR/bin/install/python.sh
$DOTFILES_DIR/bin/install/node.sh
$DOTFILES_DIR/bin/install/shell.sh

echo "########################################################################"
echo "#                    Configuring OSX settings [2/4]                    #"
echo "########################################################################"

# TODO - create osx.sh with commands to set osx settings
#./install/osx.sh

echo "########################################################################"
echo "#                  Installing GUI Applications [3/4]                   #"
echo "########################################################################"

$DOTFILES_DIR/bin/install/gui.sh

echo "########################################################################"
echo "#               Installing Developmement Projects [4/4]                #"
echo "########################################################################"

$DOTFILES_DIR/bin/install/projects.sh

echo "Installation complete"

echo "Make sure all nvim plugins got installed, open nvim and run:"
echo ":PluginInstall"
echo ":PluginUpdate" 

exit 0