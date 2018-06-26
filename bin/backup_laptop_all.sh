#!/usr/bin/env bash

function printUsage() {
  cat << EOF
Usage: sudo $(basename $0)
  
Envrionment variables:

USB_DRIVE_DIR - the path to the mounted usb drive

EOF
}

USER=$(whoami)
USB_DRIVE_DIR=${USB_DRIVE_DIR:-/Volumes/WDMyPassUltra}

if [ $USER != "root" ]; then
  echo "ERROR: $(basename $0) needs to be run as root, re-run using sudo"
  echo
  printUsage
  exit 0
fi

# The next two lines stopped working so commenting them out (execute using sudo instead)
# Keep-alive: update existing `sudo` time stamp until the script has finished.
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

rsync -avh --delete --progress $HOME/Applications/ $USB_DRIVE_DIR/$(basename $HOME)/Applications
rsync -avh --delete --progress $HOME/Desktop/ $USB_DRIVE_DIR/$(basename $HOME)/Desktop
rsync -avh --delete --progress $HOME/Documents/ $USB_DRIVE_DIR/$(basename $HOME)/Documents
rsync -avh --delete --progress $HOME/Downloads/ $USB_DRIVE_DIR/$(basename $HOME)/Downloads
rsync -avh --delete --progress $HOME/Dropbox/ $USB_DRIVE_DIR/$(basename $HOME)/Dropbox
rsync -avh --delete --progress $HOME/Movies/ $USB_DRIVE_DIR/$(basename $HOME)/Movies
rsync -avh --delete --progress $HOME/Music/ $USB_DRIVE_DIR/$(basename $HOME)/Music
rsync -avh --delete --progress $HOME/Library/ $USB_DRIVE_DIR/$(basename $HOME)/Library
rsync -avh --delete --progress $HOME/Pictures/ $USB_DRIVE_DIR/$(basename $HOME)/Pictures
rsync -avh --delete --progress $HOME/Public/ $USB_DRIVE_DIR/$(basename $HOME)/Public
rsync -avh --delete --progress $HOME/Sites/ $USB_DRIVE_DIR/$(basename $HOME)/Sites
rsync -avh --delete --progress /usr/local/ $USB_DRIVE_DIR/USBLOCALBACKUP/usr/local
rsync -avh --delete --progress /usr/local/ $USB_DRIVE_DIR/USBLOCALBACKUP/usr/local
rsync -avh --delete --progress $HOME/.* $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES

# Having to use zsh here because bash does wierd filename expansion when matching
# dotfiles, gnu bash reference and all scripting ebooks on my laptop are useless 
# and the internet has been cut off again so there is no way of finding how to get 
# bash to match dotfiles in a sane way. Will someone write a bash book that isn't a 
# total waste of time?
# TODO - Find a way to match dotfiles using bash, remove this winey comment
zsh -c 'rsync -avh --delete --progress $HOME/.* $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES'

echo "THERE ARE DOT FILES IN THIS FOLDER" > $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES/DOTFILES_IN_THIS_FOLDER.txt
echo "Listing folder contents:"
ls -la $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES >> $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES/DOTFILES_IN_THIS_FOLDER.txt

