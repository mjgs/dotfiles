#!/bin/sh

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

echo "########################################################################"
echo "#                      Installing dotfiles                             #"
echo "########################################################################"

CWD=$(pwd)
CONFIGS_DIR=${CONFIGS_DIR:?}
CODES_DIR=${CODES_DIR:?}
DOTFILES_DIR=${DOTFILES_DIR:?}
REPO_URL=${REPO_URL:?}
REPO_URL_LOCAL=${REPO_URL_LOCAL:?}
DOTFILES_URL=$REPO_URL/dotfiles.git
DOTFILES_LOCAL_URL=$REPO_URL_LOCAL/dotfiles_local.git

if [ ! -x /usr/bin/git ]; then
  echo "ERROR: Apple's version of git must be installed"
  exit 1
fi

function backupDotfiles() {
  cd $CONFIGS_DIR

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

installLatestDotfileRepos() {
  echo "Cloning dotfiles_local repo...$DOTFILES_LOCAL_URL"
  git clone $DOTFILES_LOCAL_URL $CONFIGS_DIR

  echo "Cloning dotfiles repo...$DOTFILES_URL"
  git clone $DOTFILES_URL $CONFIGS_DIR
}

function createDotfilesSymlinks() {
  echo "Creating ~/ dotfile symlinks..."

  LINKABLES=$( find -H "$CONFIGS_DIR" -maxdepth 3 -name '*.symlink' )

  for FILE in $LINKABLES; do
    TARGET="$HOME/.$( basename $FILE ".symlink" )"
    if [ -e $TARGET ]; then
      echo "${TARGET} already exists... Skipping."
    else
      echo "Creating $TARGET symlink to $FILE"
      ln -s $FILE $TARGET
    fi
  done
}

function createXDGDotfilesSymlinks() {
  echo "Creating XDG ~/.config dotfile symlinks..."
  
  # XDG Base Directory Specification: 
  # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
  if [ ! -d $HOME/.config ]; then
    echo "Creating ~/.config"
    mkdir -p $HOME/.config
  fi

  CONFIGS=$( find -H "$DOTFILES_DIR/config" -maxdepth 2 -name '*.symlink' )

  for CONFIG in $CONFIGS; do
    TARGET="$HOME/.config/$( basename $CONFIG ".symlink" )"
    if [ -e $TARGET ]; then
      echo "~${TARGET#$HOME} already exists... Skipping."
    else
      echo "Creating $TARGET symlink to $CONFIG"
      ln -s $CONFIG $TARGET
    fi
  done
}

echo "Copy and paste your public key to your dotfiles  code repositories"
read -p "Hit enter to continue..." enter

backupDotfiles
installLatestDotfileRepos
createDotfilesSymlinks
createXDGDotfilesSymlinks

if [ -x $CONFIGS_DIR/dotfiles_local.sh ]; then
  $CONFIGS_DIR/dotfiles_local.sh			
fi

exit 0
