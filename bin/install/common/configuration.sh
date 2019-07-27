#!/bin/sh

#
# Description: configures installed apps
#
 
# Run configuration.sh after all items have been installed since some
# configuration requires that certain environments are installed.
# e.g. YouCompleteMe requires node and npm to be installed to compile

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}

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
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  # Silent install of vim plugins doesn't work
  #echo "$PFX Installing vim plugins to $HOME/.vim/bundle (no output to console, might take a while)..."
  #nvim +PluginInstall +PluginUpdate +qall &>/dev/null
  read -p "Open nvim / vim and install plugins :PluginInstall" enter1
  read -p "Open nvim / vim and update plugins :PluginUpdate" enter2

  echo "$PFX Configuring vim color schemes..."
  rsync -avz $HOME/.vim/bundle/vim-colorschemes/colors $HOME/.vim

  echo "$PFX Configuring vim web indent..."
  rsync -avz $HOME/.vim/bundle/vim-web-indent/indent $HOME/.vim

  echo "$PFX Configuring ycm vim plugin..."
  $HOME/.vim/bundle/YouCompleteMe/install.py --tern-completer

  echo "$PFX Configuring tern_for_vim vim plugin..."
  current_dir=`pwd`; 
  cd $HOME/.vim/bundle/tern_for_vim
  source ~/.nvm/nvm.sh # load nvm
  nvm use stable
  npm install 
  cd $current_dir

  echo "$PFX When install.sh completes..."
  echo "$PFX Make sure all nvim plugins got installed, open nvim and run:"
  echo ":PluginInstall"
  echo ":PluginUpdate" 
}

function configureOpenvpn() {
  echo "$PFX Configuring openvpn..."
  echo "$PFX Have launchd start openvpn at startup..."
  sudo cp -fv /usr/local/opt/openvpn/*.plist /Library/LaunchDaemons
  sudo chown root /Library/LaunchDaemons/homebrew.mxcl.openvpn.plist
}

#
# Main
#

configureNvim
configureOpenvpn

exit 0