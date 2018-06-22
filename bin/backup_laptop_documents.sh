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
