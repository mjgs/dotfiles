#!/bin/sh
#
# Description: installs brew packages

if [ ! $CONFIGS_DIR ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! -x /usr/local/bin/brew ]; then
  echo "Installing homebrew..."
  ruby -e "$(curl \
    -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew packages..."
brew install ack
brew install cmake
brew install git
brew install git-extras
brew install heroku-toolbelt
brew install httpie
brew install iperf
brew install jq
brew install mongodb
brew install neovim/neovim/neovim
brew install nvm
brew install openssl
brew install redis
brew install tree
brew install watch
brew install wget
brew install youtube-dl
brew install doctl
brew install shellcheck

if [ -x $CONFIGS_DIR/brew_local.sh ]; then
  $CONFIGS_DIR/brew_local.sh			
fi

exit 0
