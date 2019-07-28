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
CONFIGS_DIR=${CONFIGS_DIR:-$CWD/Configs}
CODES_DIR=${CODES_DIR:-$CWD/Codes}
REPO=${REPO:-git@github.com:mjgs/dotfiles.git}
REPO_LOCAL=${REPO_LOCAL:-git@github.com:mjgs/dotfiles_local.git}
REPO_DIR=$CONFIGS_DIR/$(basename ${REPO%.git})
REPO_LOCAL_DIR=$CONFIGS_DIR/$(basename ${REPO_LOCAL%.git})

export PFX CONFIGS_DIR CODES_DIR REPO REPO_DIR REPO_LOCAL REPO_LOCAL_DIR

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
  export NAME

  read -p "What is your email address? " EMAIL
  export EMAIL
}

function createDirectories() {
  echo "$PFX Creating CONFIGS_DIR: $CONFIGS_DIR"
  mkdir -p $CONFIGS_DIR

  echo "$PFX Creating CODES_DIR: $CODES_DIR"
  mkdir -p $CODES_DIR

  echo "$PFX Creating REPO_DIR: $REPO_DIR"
  mkdir -p $REPO_DIR
  
  echo "$PFX Creating REPO_LOCAL_DIR: $REPO_LOCAL_DIR"
  mkdir -p $REPO_LOCAL_DIR
}

function cloneLatestDotfileRepos() {
  echo "$PFX CONFIGS_DIR: $CONFIGS_DIR"

  echo "$PFX Cloning dotfiles_local repo: $DOTFILES_LOCAL_REPO_URL"
  REPO_NAME_LOCAL=$(basename $DOTFILES_LOCAL_REPO_URL)
  git clone $DOTFILES_LOCAL_REPO_URL $DOTFILES_REPO_DIR

  echo "$PFX Cloning dotfiles repo: $DOTFILES_REPO_URL"
  REPO_NAME=$(basename $DOTFILES_REPO_URL)
  git clone $DOTFILES_REPO_URL $DOTFILES_LOCAL_REPO_DIR
}

function runInstallScripts() {
  echo "$PFX Running install scripts..."
  
  $DOTFILES_DIR/bin/install/common/install.sh
  $DOTFILES_DIR/bin/install/$OS/install.sh
  $DOTFILES_DIR/bin/install/common/configuration.sh
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

#getAdminPassword
getUserInfo
createDirectories
cloneLatestDotfileRepos
runInstallScripts

TIMESTAMP_END=$(date)
echo "$PFX Installation started: $TIMESTAMP_START"
echo "$PFX Installation complete: $TIMESTAMP_END"

echo "TODO: Make sure all nvim plugins got installed, open nvim and run:"
echo ":PluginInstall"
echo ":PluginUpdate" 

exit 0
