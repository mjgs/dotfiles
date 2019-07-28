#!/usr/bin/env bash

#
# Description: configures installed apps
#
 
if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
CWD=$(pwd)

function configureNvim() {
  echo "$PFX Configuring nvim..."

  echo "$PFX Linking nvim to vim configuration..."
  NVIM_DIR=$HOME/.config/nvim
  NVIM_INIT=$HOME/.config/nvim/init.vim

  if [ -e $NVIM_DIR ]; then 
    echo "$PFX $NVIM_DIR already exists... Skipping."    
  else
    echo "$PFX Creating $HOME/.vim symlink to $NVIM_DIR"
    ln -s $HOME/.vim $HOME/.config/nvim
  fi

  if [ -e $NVIM_INIT ]; then 
    echo "$PFX $NVIM_INIT already exists... Skipping." 
  else
    echo "$PFX Creating $HOME/.vimrc symlink to $NVIM_INIT"
    ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
  fi

  echo "$PFX Installing vim plugin manager Vundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

  # Silent install of vim plugins doesn't work
  #echo "$PFX Installing vim plugins to $HOME/.vim/bundle (no output to console, might take a while)..."
  #nvim +PluginInstall +PluginUpdate +qall &>/dev/null
  read -p "Open nvim / vim and install plugins :PluginInstall" enter1
  read -p "Open nvim / vim and update plugins :PluginUpdate" enter2

  echo "$PFX Configuring vim color schemes..."
  rsync -avz $HOME/.vim/bundle/vim-colorschemes/colors $HOME/.vim

  echo "$PFX Configuring vim web indent..."
  rsync -avz $HOME/.vim/bundle/vim-web-indent/indent $HOME/.vim

  echo "$PFX When install.sh completes..."
  echo "$PFX Make sure all nvim plugins got installed, open nvim and run:"
  echo ":PluginInstall"
  echo ":PluginUpdate" 
}

#
# Main
#

configureNvim

exit 0
