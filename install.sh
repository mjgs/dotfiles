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
CODES_DIR=${CODES_DIR:-$HOME/Codes}
DOTFILES_REPO=${DOTFILES_REPO:-git@github.com:mjgs/dotfiles.git}
DOTFILES_LOCAL_REPO=${DOTFILES_LOCAL_REPO:-git@github.com:mjgs/dotfiles_local.git}
DOTFILES_RELATIVE_BASE=${DOTFILES_RELATIVE_BASE:-Codes}

CWD=$(pwd)
DOTFILES_DIR=$CODES_DIR/$(basename ${DOTFILES_REPO%.git})
DOTFILES_LOCAL_DIR=$CODES_DIR/$(basename ${DOTFILES_LOCAL_REPO%.git})
HOMEBREW_URL=https://raw.githubusercontent.com/Homebrew/install/master/install

function printUsage() {
  echo "Usage: install.sh"
  echo
  echo
  echo "Environment variables:"
  echo 
  echo "  HOME                - user home directory"
  echo "  OS_TYPE             - osx (*)"
  echo "  CODES_DIR           - path to directory where dotfiles repos will be cloned (d)"
  echo "  DOTFILES_REPO       - ssh connection string for dotfiles repository (d)"
  echo "  DOTFILES_LOCAL_REPO - ssh connection string for dotfiles_local repository (d)"
  echo 
  echo "  (d) - indicates that a default is set, see code for details"
  echo
  echo "  (*) - add other os types scripts to bin/install/<os_type>"
  echo
}

function printVariables() {
  echo "$PFX Environment variables set:"
  echo
  echo "  OS_TYPE: $OS_TYPE"
  echo "  HOME: $HOME"
  echo "  CODES_DIR: $CODES_DIR"
  echo "  DOTFILES_REPO: $DOTFILES_REPO"
  echo "  DOTFILES_LOCAL_REPO: $DOTFILES_LOCAL_REPO"
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
  echo "$PFX Creating CODES_DIR: $CODES_DIR"
  mkdir -p $CODES_DIR
}

function cloneLatestDotfileRepos() {
  echo "$PFX Add your public key to your dotfiles code repositories before continuing"
  read -p "$PFX Hit enter to continue..." enter

  echo "$PFX Cloning repo: $DOTFILES_LOCAL_REPO"
  echo "$PFX Target directory: $DOTFILES_LOCAL_DIR"
  if [ ! -e "$DOTFILES_LOCAL_DIR" ]; then
    git clone $DOTFILES_LOCAL_REPO $DOTFILES_LOCAL_DIR
  else
    echo "$PFX Target directory exists, skipping..."
  fi

  echo "$PFX Cloning repo: $DOTFILES_REPO"
  echo "$PFX Target directory: $DOTFILES_DIR"
  if [ ! -e "$DOTFILES_DIR" ]; then
    git clone $DOTFILES_REPO $DOTFILES_DIR
  else
    echo "$PFX Target directory exists, skipping..."
  fi
}

function exportVariables() {
  export PFX
  export DOTFILES_DIR
  export CODES_DIR
  export DOTFILES_REPO
  export DOTFILES_DIR
  export DOTFILES_LOCAL_REPO
  export DOTFILES_LOCAL_DIR
  export DOTFILES_RELATIVE_BASE
  export NAME
  export EMAIL
  export HOMEBREW_URL
}

function runInstallScripts() {
  echo "$PFX Running install scripts..."

  # Configure git, ssh keys and dotfiles here since they are needed during the installation
  $DOTFILES_DIR/bin/install/common/configurations/cli/git.sh
  $DOTFILES_DIR/bin/install/common/configurations/cli/publicPrivateKeyPair.sh

  # dotfiles_local install
  if [ -d "$DOTFILES_LOCAL_DIR"  ]; then
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
