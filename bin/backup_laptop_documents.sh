#!/bin/sh

sudo rsync -avh --delete --progress $HOME/Documents/ $USB_DRIVE_DIR/$(basename $HOME)/Documents
