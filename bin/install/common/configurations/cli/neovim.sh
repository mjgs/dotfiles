#!/usr/bin/env bash

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
XDG_CONFIG_DIR=$HOME/.config
NVIM_DIR=$XDG_CONFIG_DIR/nvim
NVIM_INIT=$XDG_CONFIG_DIR/init.vim
VIM_DIR=$HOME/.vim

echo "$PFX Configuring package: neovim"

echo "$PFX Linking nvim to vim configuration..."

if [ -e $NVIM_DIR ]; then 
  echo "$PFX $NVIM_DIR already exists... Skipping."    
else
  echo "$PFX Creating $HOME/.vim symlink to $NVIM_DIR"
  ln -s $HOME/.vim $NVIM_DIR
fi

if [ -e $NVIM_INIT ]; then 
  echo "$PFX $NVIM_INIT already exists... Skipping." 
else
  echo "$PFX Creating $HOME/.vimrc symlink to $NVIM_INIT"
  ln -s $HOME/.vimrc $NVIM_INIT
fi

echo "$PFX Installing vim plugin manager Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git $VIM_DIR/bundle/Vundle.vim

# Silent install of vim plugins doesn't work
#echo "$PFX Installing vim plugins to $HOME/.vim/bundle (no output to console, might take a while)..."
#nvim +PluginInstall +PluginUpdate +qall &>/dev/null
read -p "Open nvim / vim and install plugins :PluginInstall" enter1
read -p "Open nvim / vim and update plugins :PluginUpdate" enter2

echo "$PFX Configuring vim color schemes..."
rsync -avz $VIM_DIR/bundle/vim-colorschemes/colors $VIM_DIR

echo "$PFX Configuring vim web indent..."
rsync -avz $VIM_DIR/bundle/vim-web-indent/indent $VIM_DIR

echo "$PFX When install.sh completes..."
echo "$PFX Make sure all nvim plugins got installed, open nvim and run:"
echo ":PluginInstall"
echo ":PluginUpdate"

exit 0
