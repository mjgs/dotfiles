#!/bin/sh
#
# Description: installs brew packages

if [ ! -x /usr/local/bin/brew ]; then
  echo "Installing homebrew..."
  ruby -e "$(curl \
    -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew packages..."
brew install ack
brew install cmake
brew install dos2unix
brew install ffmpeg
brew install fontconfig
brew install freetype
brew install git
brew install git-extras
brew install gnupg
brew install heroku-toolbelt
brew install httpie
brew install imagemagick
brew install iperf
brew install jq
brew install media-info
brew install mongodb
brew install mysql
brew install neovim/neovim/neovim
brew install nmap
brew install nvm
brew install openssl
sudo brew install Caskroom/cask/tuntap # Needed for openvpn
brew install openvpn
brew install tree
brew install wget
brew install youtube-dl
brew install z

if [ -x $CONFIGS_DIR/brew_local.sh ]; then
  $CONFIGS_DIR/brew_local.sh			
fi

exit 0
