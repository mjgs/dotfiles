#!/bin/sh
#
# Description: Installs fresh Mac OSX environment
#
# Usage: 
# export CONFIGS_DIR=/path/to/dir (optional)
# export CODES_DIR=/path/to/dir (optional)
# install.sh

# Ask for the administrator password upfront.
echo "Admin password is required for install..."
sudo -v

read -p "What is your name? " NAME
export NAME

read -p "What is your email address? " EMAIL
export EMAIL

read -p "What is your favorite colour? " COLOUR
export COLOUR

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Checking public/private key pair..."
if [ -e ~/.ssh/id_rsa ]
then
  echo "Your public key:"
  cat ~/.ssh/id_rsa.pub
else
  echo "You don't have a public / private key pair..."
  ssh-keygen -t rsa -C $EMAIL
  echo "Your public key:"
  cat ~/.ssh/id_rsa.pub
fi

echo "Copy and paste your public key to your code repositories"
read -p "Hit enter to continue..." enter

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

echo "Checking Config directory..."
CURRENT_DIR=`pwd`

if [ ! $CONFIGS_DIR ]; then
  CONFIGS_DIR=$CURRENT_DIR/Configs
fi

export CONFIGS_DIR=$CONFIGS_DIR

echo "Cloning dotfiles_local repo..."
echo "dotfiles_local repository: $DOTFILES_LOCAL_URL"
git clone $DOTFILES_LOCAL_URL $CONFIGS_DIR

echo "Cloning dotfiles repo..."
DOTFILES_DIR=$CONFIGS_DIR/dotfiles
echo "dotfiles repository: $DOTFILES_URL"
git clone $DOTFILES_URL $DOTFILES_DIR

echo "Checking Codes directory..."
if [ ! $CODES_DIR ]; then
  CODES_DIR=$CURRENT_DIR/Codes
fi

if [ ! -e $CODES_DIR ]; then
  echo "Creating codes directory: $CODES_DIR"
  mkdir $CODES_DIR
fi

export CODES_DIR=$CODES_DIR

exit

echo "Running install scripts..."
$DOTFILES_DIR/bin/install/dotfiles.sh
$DOTFILES_DIR/bin/install/brew.sh
$DOTFILES_DIR/bin/install/ruby.sh
$DOTFILES_DIR/bin/install/python.sh
$DOTFILES_DIR/bin/install/node.sh
$DOTFILES_DIR/bin/install/shell.sh
$DOTFILES_DIR/bin/install/configuration.sh

echo "########################################################################"
echo "#                    Configuring OSX settings [2/4]                    #"
echo "########################################################################"

$DOTFILES_DIR/bin/osx/set_system_prefs.sh
$DOTFILES_DIR/bin/osx/set_hidden_prefs.sh
$DOTFILES_DIR/bin/osx/set_application_prefs.sh
$DOTFILES_DIR/bin/osx/configure_dock_apps.sh

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
