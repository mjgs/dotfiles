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

echo "THERE ARE DOT FILES IN THIS FOLDER: ls -la to see them" > $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES/README.txt

