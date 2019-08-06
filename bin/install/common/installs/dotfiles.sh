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
REPO_DIR=${REPO_DIR:?}
REPO_LOCAL_DIR=${REPO_LOCAL_DIR:?}

function createRegularDotfilesSymlinks() {
  local THIS_REPO_DIR=$1

  echo "$PFX Creating dotfile symlinks in directory: $HOME"
  echo "$PFX Target repo: $THIS_REPO_DIR"

  cd $THIS_REPO_DIR
  LINKABLES=$( find -H . -maxdepth 3 -name '*.symlink' )
  cd $CWD

  for FILE in $LINKABLES; do
    DOTFILE=$HOME/.$(basename $FILE '.symlink')
    if [ -e $DOTFILE ]; then
      echo "$PFX Skipping ${DOTFILE}, already exists..."
    else
      local BASE_PATH=Documents/Codes/projects
      local SOURCE=$BASE_PATH/$(basename $THIS_REPO_DIR)/${FILE:2}
      local TARGET=$HOME/.$(basename $FILE '.symlink')

      echo "$PFX Creating $TARGET symlink to $SOURCE"
      ln -s $SOURCE $TARGET
    fi
  done
}

function createXDGDotfilesSymlinks() {
  local THIS_REPO_DIR=$1

  local XDG_CONFIG_DIR=$THIS_REPO_DIR/config

  echo "$PFX Creating XDG dotfile symlinks in directory: $HOME/.config"

  if [ -e $XDG_CONFIG_DIR ]; then
    # XDG Base Directory Specification: 
    # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
    if [ ! -d $HOME/.config ]; then
      echo "$PFX Creating $HOME/.config"
      mkdir -p $HOME/.config
    fi

    cd $XDG_CONFIG_DIR
    CONFIGS=$( find -H "$XDG_CONFIG_DIR" -maxdepth 2 -name '*.symlink' )
    cd $CWD

    for CONFIG in $CONFIGS; do
      DOTFILE=$HOME/.config/$(basename $CONFIG '.symlink')
      if [ -e $DOTFILE ]; then
        echo "$PFX Skipping ~${DOTFILE#$HOME} already exists..."
      else
        local BASE_PATH=Documents/Codes/projects
        local SOURCE=$BASE_PATH/$(basename $THIS_REPO_DIR)/config/${CONFIG:2}
        local TARGET=$HOME/.config/$(basename $CONFIG '.symlink')

        echo "$PFX Creating $TARGET symlink to $SOURCE"
        ln -s $SOURCE $TARGET
      fi
    done
  else
    echo "No XDG dotfiles directory in this repo, skipping..."
  fi
}

function createDotfilesSymlinks() {
  echo "$PFX Installing dotfiles"
 
  createRegularDotfilesSymlinks $REPO_DIR
  createXDGDotfilesSymlinks $REPO_DIR

  createRegularDotfilesSymlinks $REPO_LOCAL_DIR
}

#
# Main
#

createDotfilesSymlinks

exit 0
