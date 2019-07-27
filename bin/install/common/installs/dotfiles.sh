#!/usr/bin/env bash

#
# Description: installs dotfiles
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}

echo "$PFX Installing dotfiles"

CWD=$(pwd)
CONFIGS_DIR=${CONFIGS_DIR:?}
CODES_DIR=${CODES_DIR:?}
DOTFILES_DIR=${DOTFILES_DIR:?}
DOTFILES_REPO_URL=${DOTFILES_REPO_URL:?}
DOTFILES_LOCAL_REPO_URL=${DOTFILES_LOCAL_REPO_URL:?}
DOTFILES_REPO_DIR=$CONFIGS_DIR/${REPO_NAME%.git}
DOTFILES_LOCAL_REPO_DIR=$CONFIGS_DIR/${REPO_NAME_LOCAL%.git}

function backupDotfiles() {
  cd $CONFIGS_DIR

  echo "$PFX Backing up existing dotfiles"

  if [ -d $CONFIGS_DIR/dotfiles_local ]; then
    tar cvfz dotfiles_local-$(date +%Y-%m-%d-%H%M).tar.gz $CONFIGS_DIR/dotfiles_local
    rm -rf $CONFIGS_DIR/dotfiles_local
  fi

  if [ -d $CONFIGS_DIR/dotfiles ]; then
    tar cvfz dotfiles-$(date +%Y-%m-%d-%H%M).tar.gz $CONFIGS_DIR/dotfiles
    rm -rf $CONFIGS_DIR/dotfiles
  fi

  cd $CWD
}

function createRegularDotfilesSymlinks() {
  local REPO_DIR=$1

  echo "$PFX Creating dotfile symlinks in directory: $HOME"

  LINKABLES=$( find -H "$REPO_DIR" -maxdepth 3 -name '*.symlink' )

  for FILE in $LINKABLES; do
    TARGET="$HOME/.$( basename $FILE ".symlink" )"
    if [ -e $TARGET ]; then
      echo "$PFX ${TARGET} already exists... Skipping."
    else
      echo "$PFX Creating $TARGET symlink to $FILE"
      ln -s $FILE $TARGET
    fi
  done
}

function createXDGDotfilesSymlinks() {
  local REPO_DIR=$1

  echo "$PFX Creating XDG dotfile symlinks in directory: $HOME/.config"
  
  # XDG Base Directory Specification: 
  # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
  if [ ! -d $HOME/.config ]; then
    echo "$PFX Creating $HOME/.config"
    mkdir -p $HOME/.config
  fi

  CONFIGS=$( find -H "$REPO_DIR/config" -maxdepth 2 -name '*.symlink' )

  for CONFIG in $CONFIGS; do
    TARGET="$HOME/.config/$( basename $CONFIG ".symlink" )"
    if [ -e $TARGET ]; then
      echo "$PFX ~${TARGET#$HOME} already exists... Skipping."
    else
      echo "$PFX Creating $TARGET symlink to $CONFIG"
      ln -s $CONFIG $TARGET
    fi
  done
}

function createDotfilesSymlinks() {
  createRegularDotfilesSymlinks $DOTFILES_REPO_DIR
  createXDGDotfilesSymlinks $DOTFILES_REPO_DIR

  createRegularDotfilesSymlinks $DOTFILES_LOCAL_REPO_DIR
  createXDGDotfilesSymlinks $DOTFILES_LOCAL_REPO_DIR
}

#
# Main
#

echo "$PFX Copy and paste your public key to your dotfiles code repositories"
read -p "$PFX Hit enter to continue..." enter

backupDotfiles
createDotfilesSymlinks

exit 0
