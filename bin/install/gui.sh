#!/bin/sh
#
# Description: installs brew cask gui packages

if [ ! -x /usr/local/bin/brew ]; then
	echo "ERROR: Homebrew must be installed to run the gui.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/opt/brew-cask ]; then
	echo "ERROR: Homebrew Cask must be installed to run the gui.sh installer script"
  exit 1
fi

echo "Installing brew cask applications..."
brew cask install adobe-reader
brew cask install adobe-photoshop-cc
brew cask install alfred
brew cask install cord
brew cask install cyberghost
brew cask install dropbox
brew cask install evernote
brew cask install firefox
#brew cask install get-iplayer-automator https://github.com/GetiPlayerAutomator/get-iplayer-automator
brew cask install google-chrome
brew cask install handbrake
#brew cask install hemmingway-editor http://www.hemingwayapp.com
brew cask install id3-editor
brew cask install imageoptim
brew cask install iterm2
brew cask install libreoffice
brew cask install little-snitch
brew cask install m3unify
brew cask install malwarebytes-anti-malware
brew cask install omnidisksweeper
brew cask install opera
brew cask install sequel-pro
brew cask install skype
brew cask install slack
brew cask install sublime-text
brew cask install vlc
#brew cask install wd-drive-utilities http://download.wdc.com/wdapp/WD_Drive_Utilities_Installer_2_0_2_18.zip
brew cask install wd-security
brew cask install webstorm

# TODO - create casks for get0iplayer-automator, hemmingway-editor, wd-drive-utilities

if [ -x $CONFIGS_DIR/gui_local.sh ]; then
  $CONFIGS_DIR/gui_local.sh			
fi

exit 0