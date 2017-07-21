#!/bin/sh

echo "Admin password is required for backup..."
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

rsync -avh --delete --progress $HOME/Desktop/ $USB_DRIVE_DIR/$(basename $HOME)/Desktop
rsync -avh --delete --progress $HOME/Documents/ $USB_DRIVE_DIR/$(basename $HOME)/Documents
rsync -avh --delete --progress $HOME/Downloads/ $USB_DRIVE_DIR/$(basename $HOME)/Downloads
rsync -avh --delete --progress $HOME/Dropbox/ $USB_DRIVE_DIR/$(basename $HOME)/Dropbox
rsync -avh --delete --progress $HOME/Movies/ $USB_DRIVE_DIR/$(basename $HOME)/Movies
rsync -avh --delete --progress $HOME/Music/ $USB_DRIVE_DIR/$(basename $HOME)/Music
rsync -avh --delete --progress $HOME/Pictures $USB_DRIVE_DIR/$(basename $HOME)/Pictures
rsync -avh --delete --progress $HOME/Public/ $USB_DRIVE_DIR/$(basename $HOME)/Public
rsync -avh --delete --progress $HOME/Sites/ $USB_DRIVE_DIR/$(basename $HOME)/Sites
