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
HOME=${HOME:?}
DOTFILES_DIR=${DOTFILES_DIR:?}
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
    configureApplication $APPLICATION
    echo "$PFX Install complete: $(date +"%Y-%m-%d-%H%M%S")"
  done
}

function configureApplication() {
  local APPLICATION=$1

  local CONFIGURATIONS_DIR=$DOTFILES_DIR/bin/install/osx/configurations/gui
  local CONFIGURATION_SCRIPT_NAME=$(echo $APPLICATION | cut -d@ -f1).sh
  local CONFIGURATION_SCRIPT=$CONFIGURATIONS_DIR/$CONFIGURATION_SCRIPT_NAME
      
  if [ -e $CONFIGURATION_SCRIPT ]; then
    $CONFIGURATION_SCRIPT
  else
    echo "$PFX No configuration script..."
  fi 
}

#
# Main
#

installHomebrewCask
installHomebrewCaskPackages

exit 0
