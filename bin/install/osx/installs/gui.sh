#!/bin/sh

#
# Description: installs brew cask gui packages
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOMEBREW_CASK=/usr/local/Library/Taps/caskroom/homebrew-cask/cmd/brew-cask.rb
APPLICATIONS=(
 alfred
 firefox
 google-chrome
 imageoptim
 libreoffice
 malwarebytes
 omnidisksweeper
 opera
 skype
 sublime-text
 tor-browser 
 vlc
 docker
 mongodb-compass
 visual-studio-code
)
REPO_DIR=${REPO_DIR:?}
HOME=${HOME:?}
VSCODE_DOTFILES_DIR=$REPO_DIR/vscode
VSCODE_USER_SETTINGS_DIR="$HOME/Library/Application\ Support/Code/User"

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed"
  exit 1
fi

function installHomebrewCask() {
  echo "$PFX Installing homebrew cask..."
  
  if [ ! -x $HOMEBREW_CASK ]; then
    brew tap caskroom/cask
  else
    echo "$PFX Homebrew cask already installed, skipping..."
  fi
}

function installHomebrewCaskPackages() {
  echo "$PFX Installing homebrew cask applications..."

  for APPLICATION in "${APPLICATIONS[@]}"; do
    echo "$PFX Installing application: $APPLICATION"
    brew cask install $APPLICATION
  done
}

function configureVscode() {
  echo "$PFX Configuring vscode user settings"
    
  ln -sf "$VSCODE_DOTFILES_DIR"/settings.json "$VSCODE_USER_SETTINGS_DIR"/settings.json
  ln -sf "$VSCODE_DOTFILES_DIR"/keybindings.json "$VSCODE_USER_SETTINGS_DIR"/keybindings.json
  ln -sfn "$VSCODE_DOTFILES_DIR"/snippets "$VSCODE_USER_SETTINGS_DIR"/Code/User/snippets
}

configurePackages() {
  configureVscode
}

#
# Main
#

installHomebrewCask
installHomebrewCaskPackages
configurePackages

exit 0
