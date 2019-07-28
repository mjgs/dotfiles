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
REPO=${REPO:?}
REPO_DIR=${REPO_DIR:?}
REPO_LOCAL=${REPO_LOCAL:?}
REPO_LOCAL_DIR=${REPO_LOCAL_DIR:?}

function createRegularDotfilesSymlinks() {
  local THIS_REPO_DIR=$1

  echo "$PFX Creating dotfile symlinks in directory: $HOME"
  echo "$PFX Target repo: $THIS_REPO_DIR"

  LINKABLES=$( find -H "$THIS_REPO_DIR" -maxdepth 3 -name '*.symlink' )

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

    CONFIGS=$( find -H "$XDG_CONFIG_DIR" -maxdepth 2 -name '*.symlink' )

    for CONFIG in $CONFIGS; do
      TARGET="$HOME/.config/$( basename $CONFIG ".symlink" )"
      if [ -e $TARGET ]; then
        echo "$PFX ~${TARGET#$HOME} already exists... Skipping."
      else
        echo "$PFX Creating $TARGET symlink to $CONFIG"
        ln -s $CONFIG $TARGET
      fi
    done
  else
    echo "No XDG dotfiles directory in this repo, skipping..."
  fi
}

function createDotfilesSymlinks() {
  createRegularDotfilesSymlinks $REPO_DIR
  createXDGDotfilesSymlinks $REPO_DIR

  createRegularDotfilesSymlinks $REPO_LOCAL_DIR
}

#
# Main
#

createDotfilesSymlinks

exit 0
