#!/usr/bin/env bash

#
# Description: Installs fresh development environment
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
OS_TYPE=${OS_TYPE:?}
DOTFILES_ROOT_DIR=${DOTFILES_ROOT_DIR:?}
DOTFILES_REPO_URL=${DOTFILES_REPO_URL:?}
DOTFILES_REPO_BRANCH=${DOTFILES_REPO_BRANCH:-master}
DOTFILES_LOCAL_REPO_URL=${DOTFILES_LOCAL_REPO_URL:?}
DOTFILES_LOCAL_REPO_BRANCH=${DOTFILES_LOCAL_REPO_BRANCH:-master}
DOTFILES_RELATIVE_BASE=${DOTFILES_RELATIVE_BASE:?}

CWD=$(pwd)
HOMEBREW_URL=https://raw.githubusercontent.com/Homebrew/install/master/install
DOTFILES_DIR=$DOTFILES_ROOT_DIR/dotfiles
DOTFILES_LOCAL_DIR=$DOTFILES_ROOT_DIR/dotfiles_local

function printUsage() {
  echo "Usage: install.sh"
  echo
  echo "Environment variables:"
  echo 
  echo "  HOME                       - user home directory"
  echo "  OS_TYPE                    - osx (*)"
  echo "  DOTFILES_ROOT_DIR          - path to directory where dotfiles repos will be cloned"
  echo "  DOTFILES_REPO_URL          - dotfiles repo url (e.g git@github.com:mjgs/dotfiles.git)"
  echo "  DOTFILES_REPO_BRANCH       - branch of the dotfiles repo (default: master)"
  echo "  DOTFILES_LOCAL_REPO_URL    - dotfils_local repo url (e.g. git@github.com:mjgs/dotfiles_local.git)"
  echo "  DOTFILES_LOCAL_REPO_BRANCH - branch of the dotfiles_local repo (default: master)"
  echo "  DOTFILES_RELATIVE_BASE     - path segment used as base for relative symlink creation"
  echo "  BACKUP_DIR                 - if set used as the source path in laptop-restore.sh script" 
  echo "  (*) - add other os types scripts to bin/install/<os_type>"
  echo
}

function printVariables() {
  echo "$PFX Environment variables set:"
  echo
  echo "  OS_TYPE: $OS_TYPE"
  echo "  HOME: $HOME"
  echo "  DOTFILS_REPO_DIR: $DOTFILS_REPO_DIR"
  echo "  DOTFILES_REPO_URL: $DOTFILES_REPO_URL"
  echo "  DOTFILES_REPO_BRANCH: $DOTFILES_REPO_BRANCH"
  echo "  DOTFILES_LOCAL_REPO_URL: $DOTFILES_LOCAL_REPO_URL"
  echo "  DOTFILES_LOCAL_REPO_BRANCH: $DOTFILES_LOCAL_REPO_BRANCH"
  echo
}

function getAdminPassword() {
  # Ask for the administrator password upfront.
  echo "Admin password is required for install..."
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until the script has finished.
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

function getUserInfo() {
  read -p "What is your name? " NAME
  read -p "What is your email address? " EMAIL
}

function createDirectories() {
  echo "$PFX Creating DOTFILES_ROOT_DIR: $DOTFILES_ROOT_DIR"
  mkdir -p $DOTFILES_ROOT_DIR
}

function cloneRepo() {
  local REPO=$1
  local TARGET_DIR=$2
  local BRANCH=$3

  echo "$PFX Cloning repo: $REPO"
  echo "$PFX Target directory: $TARGET_DIR"
  echo "$PFX Branch to checkout: $BRANCH"

  if [ ! -e "$TARGET_DIR" ]; then
    git clone -b $BRANCH "$REPO" "$TARGET_DIR"
  else
    echo "$PFX Target directory exists, skipping..."
  fi
}

function cloneLatestDotfileRepos() {
  echo "$PFX Add your public key to your dotfiles code repositories before continuing"
  read -p "$PFX Hit enter to continue..." enter

  cloneRepo $DOTFILES_LOCAL_REPO_URL $DOTFILES_LOCAL_DIR $DOTFILES_LOCAL_REPO_BRANCH
  cloneRepo $DOTFILES_REPO_URL $DOTFILES_DIR $DOTFILES_REPO_BRANCH
}

function exportVariables() {
  export PFX
  export NAME
  export EMAIL
  export HOMEBREW_URL

  export DOTFILES_DIR
  export DOTFILES_REPO
  export DOTFILES_LOCAL_REPO
  export DOTFILES_LOCAL_DIR
  export DOTFILES_RELATIVE_BASE
}

function runInstallScripts() {
  echo "$PFX Running install scripts..."



  # Configure git, ssh keys and dotfiles here since they are needed during the installation
  $DOTFILES_DIR/bin/install/common/configurations/cli/git.sh
  $DOTFILES_DIR/bin/install/common/configurations/cli/publicPrivateKeyPair.sh
  $DOTFILES_DIR/bin/install/common/installs/openssl.sh
  $DOTFILES_DIR/bin/install/common/installs/dotfiles.sh

  echo "$PFX Loading $HOME/.bashrc"
  source $HOME/.bashrc

  # Restore files from backup
  if [ -d "$BACKUP_DIR" ]; then
    $DOTFILES_DIR/bin/restore_laptop.sh
  fi

  # dotfiles_local install
  if [ -d "$DOTFILES_LOCAL_DIR" ]; then
    $DOTFILES_LOCAL_DIR/install.sh
  fi

  # dotfiles install
  $DOTFILES_DIR/bin/install/common/install.sh
  $DOTFILES_DIR/bin/install/$OS_TYPE/install.sh
}

#
# Main
#

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  printUsage
  exit 1
fi

TIMESTAMP_START=$(date)
echo "$PFX dotfiles installation started: $TIMESTAMP_START"

if [ ! -x /usr/bin/git ]; then
  echo "ERROR: Apple's version of git must be installed"
  exit 1
fi

printVariables
#getAdminPassword
getUserInfo
createDirectories
cloneLatestDotfileRepos
exportVariables
runInstallScripts

TIMESTAMP_END=$(date)
echo "$PFX dotfiles installation started: $TIMESTAMP_START"
echo "$PFX dotfiles installation complete: $TIMESTAMP_END"

echo "TODO: Make sure all nvim plugins got installed, open nvim and run:"
echo ":PluginInstall"
echo ":PluginUpdate" 

exit 0
