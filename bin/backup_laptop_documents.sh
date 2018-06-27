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

rsync -avh --delete --progress $HOME/Documents/ $USB_DRIVE_DIR/$(basename $HOME)/Documents
rsync -avh --delete --progress $HOME/Desktop/ $USB_DRIVE_DIR/$(basename $HOME)/Desktop
rsync -avh --delete --progress $HOME/Public/ $USB_DRIVE_DIR/$(basename $HOME)/Public
rsync -avh --delete --progress $HOME/Sites/ $USB_DRIVE_DIR/$(basename $HOME)/Sites
rsync -avh --delete --progress /usr/local/ $USB_DRIVE_DIR/USBLOCALBACKUP/usr/local
rsync -avh --delete --progress /usr/local/ $USB_DRIVE_DIR/USBLOCALBACKUP/usr/local
rsync -avh --delete --progress $HOME/.??* $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES # dotfiles

echo "iTHERE ARE DOT FILES IN THIS FOLDER" > $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES/DOTFILES_IN_THIS_FOLDER.txt
echo "Listing folder contents:"
ls -la $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES >> $USB_DRIVE_DIR/OLDHOMEDIRDOTFILES/DOTFILES_IN_THIS_FOLDER.txt

exit 0
