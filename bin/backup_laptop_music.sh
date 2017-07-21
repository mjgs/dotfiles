#!/bin/sh

sudo rsync -avh --delete --progress $HOME/Music/ $USB_DRIVE_DIR/$(basename $HOME)/Music
