#!/usr/bin/env bash

#
# Description: Restores a backup
#

# Intended to be run to restore the files created using backup-laptop.sh

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
CODES_DIR=${CODES_DIR:?}
BACKUP_DIR=${BACKUP_DIR:?}

MAIN_BACKUP_NAME=${MAIN_BACKUP_NAME:-MAIN_BACKUP}
CODES_BACKUP_NAME=${CODES_BACKUP_NAME:-CODES_BACKUP}
DOTFILES_BACKUP_NAME=${DOTFILES_BACKUP_NAME:-DOTFILES_BACKUP}

MAIN_BACKUP_DIR=$BACKUP_DIR/$MAIN_BACKUP_NAME
CODES_BACKUP_DIR=$BACKUP_DIR/$CODES_BACKUP_NAME
DOTFILES_BACKUP_DIR=$BACKUP_DIR/$DOTFILES_BACKUP_NAME

function restoreDirectory() {
  local DESC=$1
  local SRC=$2
  local TGT=$3

  echo "$PFX Restoring $DESC..."
  echo "$PFX Source dir: $SRC"
  echo "$PFX Target dir: $TGT"
  
  # Create tgt directory in case it doesn't exist yet
  mkdir -p $TGT
  rsync -avh --progress $SRC $TGT
}

function restoreIterm2Preferences() {
  echo "$PFX Restoring iterm2 preferences..."

  local ITERM2_SRC_DIR=$DOTFILES_BACKUP_DIR/.iterm2
  local ITERM2_TGT_DIR=$HOME/.iterm2

  echo "$PFX Source directory: $ITERM2_SRC_DIR"
  echo "$PFX Target directory: $ITERM2_TGT_DIR"

  rsync -avh --progress $ITERM2_SRC_DIR/ $ITERM2_TGT_DIR
  echo
}

#
# Main
#

echo "$PFX Restoring backup..."
echo "$PFX Note that files are not deleted in the target"

TIMESTAMP_START=$(date)
echo "$PFX Backup started: $TIMESTAMP_START"
echo "$PFX Target backup dir: $BACKUP_DIR"

# Only restore the critical folders, a lot of the files backed up get re-created
# by the fresh OS install and the dotfiles install script. Folders like ~/Library 
# are in the backup in case there is some file that needs to be restored manually, 
# for example if there was a config file that wasn't added to dotfiles yet.

# It's worth remembering that if you have files in any of these folders that 
# are causing an issue, then they will be copied back to your laptop - If your
# issue keeps re-appearing use a process of elimination to determine which folder
# has the corruption

restoreDirectory "Ssh keys" $DOTFILES_BACKUP_DIR/.ssh/ $HOME/.ssh
restoreDirectory "Desktop" $MAIN_BACKUP_DIR/Desktop/ $HOME/Desktop
restoreDirectory "Documents" $MAIN_BACKUP_DIR/Documents/ $HOME/Documents
restoreDirectory "Movies" $MAIN_BACKUP_DIR/Movies/ $HOME/Movies
restoreDirectory "Music" $MAIN_BACKUP_DIR/Music/ $HOME/Music
restoreDirectory "Pictures" $MAIN_BACKUP_DIR/Pictures/ $HOME/Pictures

restoreIterm2Preferences

TIMESTAMP_END=$(date)
echo "$PFX Backup started: $TIMESTAMP_START"
echo "$PFX Backup ended: $TIMESTAMP_END"

exit 0

