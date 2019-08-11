#!/usr/bin/env bash

#
# Description: Creates a backup
#

# This is a straight up file backup, nothing fancy like incremental 
# backups happening, it's just an rsync of important files that are currently
# on the filesystem, each backup overwrites the previous backup. It's a good
# compliment to a fancy pants Time Machine backup, in case of emergency.

if [ -n "$DEBUG" ]; then
echo "$0: Setting bash option -x for debug"
PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
BACKUP_DIR=${BACKUP_DIR:?}
HOME=${HOME:?}
MAIN_BACKUP_NAME=${MAIN_BACKUP_NAME:-MAIN_BACKUP}
USRLOCAL_BACKUP_NAME=${USRLOCAL_BACKUP_NAME:-USRLOCAL_BACKUP}
DOTFILES_BACKUP_NAME=${DOTFILES_BACKUP_NAME:-DOTFILES_BACKUP}

if [ $(whoami) != "root" ]; then
echo "ERROR: $(basename $0) needs to be run as root, re-run using sudo"
exit 1
fi

function backupDirectory() {
echo "$PFX Backing up $1..."
echo "$PFX Source dir: $2"
echo "$PFX Target dir: $3"

mkdir -p $3
rsync -avh --delete --progress $2 $3
  echo
}

function backupDotfiles() {
  echo "$PFX Backing up dotfiles..."

  mkdir -p $1 
  rsync -avh --delete --progress $HOME/.??* $1

  DOTFILES_README_FILE=$1/DOTFILES_IN_THIS_FOLDER.txt
  mkdir -p $(dirname $DOTFILES_README_FILE)

  echo "$PFX Creating dotfiles readme file: $DOTFILES_README_FILE"
  echo "THERE ARE DOT FILES IN THIS FOLDER" > $DOTFILES_README_FILE
  ls -ld ~/.??* >> $DOTFILES_README_FILE
}

#
# Main
#

echo "$PFX Starting backup..."

TIMESTAMP_START=$(date)
echo "$PFX Backup started: $TIMESTAMP_START"
echo "$PFX Target backup dir: $BACKUP_DIR"

MAIN_BACKUP_DIR=$BACKUP_DIR/$MAIN_BACKUP_NAME
DOTFILES_BACKUP_DIR=$BACKUP_DIR/$DOTFILES_BACKUP_NAME
USRLOCAL_BACKUP_DIR=$BACKUP_DIR/$USRLOCAL_BACKUP_NAME

# Dotfiles
backupDotfiles $DOTFILES_BACKUP_DIR

# Main files
backupDirectory "Desktop" $HOME/Desktop/ $MAIN_BACKUP_DIR/Desktop
backupDirectory "Documents" $HOME/Documents/ $MAIN_BACKUP_DIR/Documents
backupDirectory "Library" $HOME/Library/ $MAIN_BACKUP_DIR/Library
backupDirectory "Movies" $HOME/Movies/ $MAIN_BACKUP_DIR/Movies
backupDirectory "Music" $HOME/Music/ $MAIN_BACKUP_DIR/Music
backupDirectory "Pictures" $HOME/Pictures/ $MAIN_BACKUP_DIR/Pictures

# Files from homebrew installs in /usr/local
backupDirectory "/usr/local" /usr/local/ $USRLOCAL_BACKUP_DIR/usr/local

TIMESTAMP_END=$(date)
echo "$PFX Backup started: $TIMESTAMP_START"
echo "$PFX Backup ended: $TIMESTAMP_END"

exit 0
