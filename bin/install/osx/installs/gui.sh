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
 iterm2
 libreoffice
 malwarebytes-anti-malware
 mongohub
 omnidisksweeper
 opera
 skype
 sublime-text
 torbrowser
 vlc
 wd-security
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
    echo "brew tap caskroom/cask"
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

installHomebrewCask
installHomebrewCaskPackages

exit 0
