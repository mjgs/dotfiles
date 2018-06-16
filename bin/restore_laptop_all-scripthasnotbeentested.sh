#!/usr/bin/env bash

TYPE=$1

function printUsage() {
  cat << EOF
Usage: sudo $(basename $0) <install_type>

install_type - full | partial

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

# Some items commented out:
# If you are doing a full fresh install you probably don't want to restore these
# folders anyway, but it's good to have a backup in case you need something from them

if [ "$TYPE" == "partial" ]; then
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Desktop/ $HOME/Desktop
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Documents/ $HOME/Documents
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Movies/ $HOME/Movies
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Music/ $HOME/Music
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Pictures/ $HOME/Pictures
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Public/ $HOME/Public
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Sites/ $HOME/Sites
elif [ "$TYPE" == "full" ]; then
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Applications/ $HOME/Applications
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Desktop/ $HOME/Desktop
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Documents/ $HOME/Documents
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Downloads/ $HOME/Downloads
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Dropbox/ $HOME/Dropbox
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Movies/ $HOME/Movies
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Music/ $HOME/Music
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Library/ $HOME/Library
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Pictures/ $HOME/Pictures
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Public/ $HOME/Public
  rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Sites/ $HOME/Sites
  rsync -avh --progress $USB_DRIVE_DIR/USRLOCALBACKUP/usr/local/ /usr/local
else 
  echo "install_type not supported: $TYPE"
fi

exit 0
