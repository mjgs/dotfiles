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
brew install httpie
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

echo "Linking nvim to vim configuration..."
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

echo "Installing vim plugin manager Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing vim plugins to $HOME/.vim/bundle (no output to console, might take a while)..."
nvim +PluginInstall +PluginUpdate +qall &>/dev/null

echo "Installing vim color schemes..."
rsync -avz $HOME/.vim/bundle/vim-colorschemes/colors $HOME/.vim

echo "Installing vim web indent..."
rsync -avz $HOME/.vim/bundle/vim-web-indent/indent $HOME/.vim

echo "When install.sh completes..."
echo "Make sure all nvim plugins got installed, open nvim and run:"
echo ":PluginInstall"
echo ":PluginUpdate" 

if [ -x $CONFIGS_DIR/brew_local.sh ]; then
  $CONFIGS_DIR/brew_local.sh			
fi

exit 0