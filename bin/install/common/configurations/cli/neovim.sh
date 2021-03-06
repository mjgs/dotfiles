#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}

XDG_CONFIG_DIR=$HOME/.config
NVIM_DIR=$XDG_CONFIG_DIR/nvim
VIM_DIR=$HOME/.vim
VIM_PLUGIN_MANAGER_REPO=https://github.com/VundleVim/Vundle.vim.git
VIM_BUNDLES_DIR=$VIM_DIR/bundle

echo "$PFX Configuring package: neovim"

function createNvimConfiguration() {
  echo "$PFX Creating nvim configuration..."

  mkdir -p $VIM_DIR

  if [ -L $NVIM_DIR ]; then
    echo "$PFX $NVIM_DIR already exists... Skipping."    
  else
    echo "$PFX Creating $VIM_DIR symlink to $NVIM_DIR"
    ln -s $VIM_DIR $NVIM_DIR
  fi

  if [ -L $NVIM_DIR/init.vim ]; then
    echo "$PFX $NVIM_DIR/init.vim already exists... Skipping." 
  else
    echo "$PFX Creating $HOME/.vimrc symlink to $NVIM_DIR/init.vim"
    ln -s $HOME/.vimrc $NVIM_DIR/init.vim
  fi
}

function installAndConfigureVimPluginManager() {
  echo "$PFX Installing vim plugin manager..."
  echo "$PFX Cloning repo: $VIM_PLUGIN_MANAGER_REPO"
  echo "$PFX Target directory: $VIM_BUNDLES_DIR"

  if [ ! -e $VIM_BUNDLES_DIR ]; then
    git clone $VIM_PLUGIN_MANAGER_REPO $VIM_BUNDLES_DIR/Vundle.vim
  else
    echo "$PFX Target directory exists, skipping..."
  fi

  # Silent install of vim plugins doesn't work
  #echo "$PFX Installing vim plugins to $HOME/.vim/bundle (no output to console, might take a while)..."
  #nvim +PluginInstall +PluginUpdate +qall &>/dev/null
  read -p "Open nvim / vim and install plugins :PluginInstall" enter1
  read -p "Open nvim / vim and update plugins :PluginUpdate" enter2
}

function configureNodeForNeovim() {
  echo "$PFX Configuring node for neovim..."
  npm install -g neovim 
}

function configureVimColorScheme() {
  echo "$PFX Configuring vim color schemes..."
  
  local COLORSCHEMES_DIR=$VIM_DIR/bundle/vim-colorschemes/colors
  rsync -avz $COLORSCHEMES_DIR $VIM_DIR
}

function configureVimWebIndent() {
  echo "$PFX Configuring vim web indent..."

  WEBINDENT_DIR=$VIM_DIR/bundle/vim-web-indent/indent
  rsync -avz $WEBINDENT_DIR $VIM_DIR
}

createNvimConfiguration
configureNodeForNeovim
installAndConfigureVimPluginManager
configureVimColorScheme
configureVimWebIndent

exit 0
