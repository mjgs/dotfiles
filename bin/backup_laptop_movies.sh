#!/bin/sh

sudo rsync -avh --delete --progress $HOME/Movies/ $USB_DRIVE_DIR/$(basename $HOME)/Movies
