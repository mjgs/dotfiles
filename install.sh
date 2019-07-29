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

CWD=$(pwd)
PFX=${PFX:-==>}
HOME=${HOME:?}
CONFIGS_DIR=${CONFIGS_DIR:-$CWD/Configs}
CODES_DIR=${CODES_DIR:-$CWD/Codes}
REPO=${REPO:-git@github.com:mjgs/dotfiles.git}
REPO_LOCAL=${REPO_LOCAL:-git@github.com:mjgs/dotfiles_local.git}
REPO_DIR=$CONFIGS_DIR/$(basename ${REPO%.git})
REPO_LOCAL_DIR=$CONFIGS_DIR/$(basename ${REPO_LOCAL%.git})

function printUsage() {
  echo "Usage: install.sh <os_version>"
  echo
  echo "  os_version - osx" 
  echo
  echo "To add support for other os versions add scripts to directory:" 
  echo "$DOTFILES_DIR/bin/install/[os_version]"
  echo
  echo "Environment variables:"
  echo
  echo "  CONFIGS_DIR             - path to configs directory"
  echo "  CODES_DIR               - path to codes directory"
  echo "  DOTFILES_REPO_URL       - url of repo used for dotfiles"     
  echo "  DOTFILES_LOCAL_REPO_URL - url of repo used for local dotfiles"
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
  echo "$PFX Creating CONFIGS_DIR: $CONFIGS_DIR"
  mkdir -p $CONFIGS_DIR

  echo "$PFX Creating CODES_DIR: $CODES_DIR"
  mkdir -p $CODES_DIR
}

function cloneLatestDotfileRepos() {
  echo "$PFX Copy and paste your public key to your dotfiles code repositories:"
  echo "$PFX $(cat $HOME/.ssh/id_rsa.pub)"
  read -p "$PFX Hit enter to continue..." enter

  echo "$PFX Cloning repo: $REPO_LOCAL"
  echo "$PFX Target directory: $REPO_LOCAL_DIR"
  if [ ! -e $REPO_LOCAL_DIR ]; then
    git clone $REPO_LOCAL $REPO_LOCAL_DIR
  else
    echo "$PFX Target directory exists, skipping..."
  fi

  echo "$PFX Cloning repo: $REPO"
  echo "$PFX Target directory: $REPO_DIR"
  if [ ! -e $REPO_DIR ]; then
    git clone $REPO $REPO_DIR
  else
    echo "$PFX Target directory exists, skipping..."
  fi
}

function exportVariables() {
  export PFX
  export CONFIGS_DIR
  export CODES_DIR
  export REPO
  export REPO_DIR
  export REPO_LOCAL
  export REPO_LOCAL_DIR
  export NAME EMAIL
}

function runInstallScripts() {
  echo "$PFX Running install scripts..."
  
  $REPO_DIR/bin/install/common/install.sh
  $REPO_DIR/bin/install/$OS/install.sh
  $REPO_DIR/bin/install/common/configuration.sh
}

#
# Main
#

if [ "$#" -ne 1 ]; then
  printUsage
  exit 1
fi

TIMESTAMP_START=$(date)
echo "$PFX Installation started: $TIMESTAMP_START"

if [ ! -x /usr/bin/git ]; then
  echo "ERROR: Apple's version of git must be installed"
  exit 1
fi

#getAdminPassword
getUserInfo
createDirectories
cloneLatestDotfileRepos
exportVariables
runInstallScripts

TIMESTAMP_END=$(date)
echo "$PFX Installation started: $TIMESTAMP_START"
echo "$PFX Installation complete: $TIMESTAMP_END"

echo "TODO: Make sure all nvim plugins got installed, open nvim and run:"
echo ":PluginInstall"
echo ":PluginUpdate" 

exit 0
