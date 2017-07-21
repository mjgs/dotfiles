#!/bin/sh

sudo rsync -avh --delete --progress $HOME/Pictures/ $USB_DRIVE_DIR/$(basename $HOME)/Pictures
