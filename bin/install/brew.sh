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
brew install brew-cask
brew install cmake
brew install dos2unix
brew install fontconfig
brew install freetype
brew install git
brew install gnupg
brew install heroku-toolbelt
brew install imagemagick
brew install iperf
brew install jq
brew install media-info
brew install mongodb
brew install mysql
brew install neovim
brew install nmap
brew install nvm
brew install openssl
brew install tree
brew install wget
brew install youtube-dl
brew install z

echo "Configuring installed homebrew packages..."

echo "Linking nvim to vim configuration and installing nvim plugins..."
NVIM_DIR=$HOME/.config/nvim
NVIM_INIT=$HOME/.config/nvim/init.vim

if [ -e $NVIM_DIR ]; then 
	echo "$NVIM_DIR already exists... Skipping."    
else
	echo "Creating $HOME/.vim symlink to $NVIM_DIR"
  ln -s $HOME/.vim $HOME/.config/nvim
fi

if [ -e $NVIM_INIT ]; then 
	echo "$NVIM_INIT already exists... Skipping."    
else
	echo "Creating $HOME/.vimrc symlink to $NVIM_INIT"
  ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
fi

nvim +PluginInstall +qall

if [ -x $CONFIGS_DIR/brew_local.sh ]; then
  $CONFIGS_DIR/brew_local.sh			
fi

exit 0