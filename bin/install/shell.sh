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

if [ ! -x /usr/local/bin/bash ]; then
  echo "Installing latest bash version..."
  brew install bash
  echo /usr/local/bin/bash >> /private/etc/shells
  chsh -s /usr/local/bin/bash
fi

if [ -x $CONFIGS_DIR/shell_local.sh ]; then
  $CONFIGS_DIR/shell_local.sh			
fi

exit 0
