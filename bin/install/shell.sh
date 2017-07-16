#!/bin/sh
#
# Description: installs shell

if [ ! $CONFIGS_DIR ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the shell.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/bin/zsh ]; then
  echo "Installing zsh..."
  brew install zsh
fi

echo "Installing oh-my-zsh..."
# Use manual instalation method - clone repo, then change shell
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh

if [ -x $CONFIGS_DIR/shell_local.sh ]; then
  $CONFIGS_DIR/shell_local.sh			
fi

exit 0
