#!/bin/sh
#
# Description: installs brew cask gui packages

if [ ! $CONFIGS_DIR ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the gui.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/Library/Taps/caskroom/homebrew-cask/cmd/brew-cask.rb ]; then
  echo "Installing brew cask..."
  brew tap caskroom/cask
fi

echo "Installing brew cask applications..."
brew cask install adobe-reader
brew cask install alfred
brew cask install cord
brew cask install cyberghost
brew cask install diskmaker-x
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install id3-editor
brew cask install imageoptim
brew cask install iterm2
brew cask install libreoffice
brew cask install little-snitch
brew cask install m3unify
brew cask install malwarebytes-anti-malware
brew cask install mongohub
brew cask install omnidisksweeper
brew cask install opera
brew cask install shiftit
brew cask install skype
brew cask install sublime-text
brew cask install vlc
brew cask install wd-security
brew cask install webstorm

if [ -x $CONFIGS_DIR/gui_local.sh ]; then
  $CONFIGS_DIR/gui_local.sh
fi

exit 0
