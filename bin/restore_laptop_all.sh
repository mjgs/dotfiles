#!/bin/sh

echo "Admin password is required for backup..."
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Some items commented out:
# If you are doing a full fresh install you probably don't want to restore these
# folders anyway, but it's good to have a backup in case you need something from them

#rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Applications/ $HOME/Applications
rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Desktop/ $HOME/Desktop
rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Documents/ $HOME/Documents
#rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Downloads/ $HOME/Downloads
#rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Dropbox/ $HOME/Dropbox
rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Movies/ $HOME/Movies
rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Music/ $HOME/Music
#rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Library/ $HOME/Library
rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Pictures/ $HOME/Pictures
rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Public/ $HOME/Public
rsync -avh --progress $USB_DRIVE_DIR/$(basename $HOME)/Sites/ $HOME/Sites

#rsync -avh --progress $USB_DRIVE_DIR/USRLOCALBACKUP/usr/local/ /usr/local

