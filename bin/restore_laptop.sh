#!/usr/bin/env bash

#
# Description: Restores a backup
#

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
DOTFILES_BACKUP_NAME=${DOTFILES_BACKUP_NAME:-DOTFILES_BACKUP}
BACKUP_CODES_DIR=$BACKUP_DIR/Documents/Codes/projects

function restoreDirectory() {
  echo "$PFX Restoring $1..."
  echo "$PFX Source dir: $2"
  echo "$PFX Target dir: $3"
  
  # Create tgt directory in case it doesn't exist yet
  mkdir -p $3

  CMD="rsync -avh --progress"
  
  # Add excluded dirs 
  if [ -n "$4" ]; then
    IFS=',' read -r -a EXCLUDES <<< "$4"
    for EXCLUDE in "${EXCLUDES[@]}"; do
      CMD="$CMD --exclude $EXCLUDE"
    done
  fi
  CMD="$CMD $2 $3"

  # Run the rsync command
  $CMD
  echo
}

function restoreProjectVscodeDirectories() {
  echo "$PFX Restoring project vscode directories..."
 
  local BACKUP_CODES_DIR=$MAIN_BACKUP_DIR/Documents/Codes/projects

  for FOLDER in $(ls $BACKUP_CODES_DIR); do
    local VSCODE_SRC_DIR=$BACKUP_CODES_DIR/$FOLDER/.vscode
    local VSCODE_TGT_DIR=$HOME/Documents/Codes/projects/$FOLDER/.vscode

    if [ -e "$VSCODE_SRC_DIR" ]; then
      echo "$PFX Restoring directory: $VSCODE_SRC_DIR"
      echo "$PFX Target directory: $VSCODE_TGT_DIR"
      mkdir -p $VSCODE_TGT_DIR
      rsync -avh --progress $VSCODE_SRC_DIR/ $VSCODE_TGT_DIR 
    else
      echo "$PFX Skipping restore: No vscode directory for project: $FOLDER"
    fi
  done
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
# are there in case there is some file that needs to be restored manually, for 
# example if there was a config file that wasn't added to dotfiles yet. I exclude
# the Codes directory from the restore because I re-create this in a dotfiles_local
# install script (you might want to do this differently)

# It's worth remembering that if you have files in any of these folders that 
# are causing an issue, then they will be copied back to your laptop - If your
# issue keeps re-appearing use a process of elimination to determine which folder
# has the corruption

MAIN_BACKUP_DIR=$BACKUP_DIR/$MAIN_BACKUP_NAME
DOTFILES_BACKUP_DIR=$BACKUP_DIR/$DOTFILES_BACKUP_NAME

restoreDirectory "Ssh keys" $DOTFILES_BACKUP_DIR/.ssh/ $HOME/.ssh
restoreDirectory "Desktop" $MAIN_BACKUP_DIR/Desktop/ $HOME/Desktop
restoreDirectory "Documents" $MAIN_BACKUP_DIR/Documents/ $HOME/Documents "Codes"
restoreDirectory "Movies" $MAIN_BACKUP_DIR/Movies/ $HOME/Movies
restoreDirectory "Music" $MAIN_BACKUP_DIR/Music/ $HOME/Music
restoreDirectory "Pictures" $MAIN_BACKUP_DIR/Pictures/ $HOME/Pictures

restoreProjectVscodeDirectories 
restoreIterm2Preferences

TIMESTAMP_END=$(date)
echo "$PFX Backup started: $TIMESTAMP_START"
echo "$PFX Backup ended: $TIMESTAMP_END"

exit 0

