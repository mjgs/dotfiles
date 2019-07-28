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

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed"
  exit 1
fi

function installHomebrewCask() {
  if [ ! -x /usr/local/Library/Taps/caskroom/homebrew-cask/cmd/brew-cask.rb ]; then
    echo "$PFX Installing homebrew cask..."
    brew tap caskroom/cask
  fi
}

function installHomebrewCaskPackages() {
  echo "$PFX Installing homebrew cask applications..."

  brew cask install alfred
  brew cask install firefox
  brew cask install google-chrome
  brew cask install imageoptim
  brew cask install iterm2
  brew cask install libreoffice
  brew cask install malwarebytes-anti-malware
  brew cask install mongohub
  brew cask install omnidisksweeper
  brew cask install opera
  brew cask install skype
  brew cask install sublime-text
  brew cask install torbrowser
  brew cask install vlc
  brew cask install wd-security
  brew cask install docker
  brew cask install mongodb-compass
  brew cask install visual-studio-code
}

installHomebrewCask
installHomebrewCaskPackages

exit 0
