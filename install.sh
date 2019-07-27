#!/bin/sh

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
PFX="==>"
CONFIGS_DIR=${CONFIGS_DIR:$CWD/Configs}
CODES_DIR=${CODES_DIR:$CWD/Codes}
DOTFILES_DIR=${DOTFILES_DIR:?}
REPO_URL=${REPO_URL:-http://github.com/mjgs}
REPO_URL_LOCAL=${REPO_URL_LOCAL:-http://github.com/mjgs}

export CONFIGS_DIR CODES_DIR DOTFILES_DIR REPO_URL REPO_URL_LOCAL

function printUsage() {
  echo "Usage: install.sh <os_version>"
  echo
  echo "Environment variables:"
  echo
  echo "CONFIGS_DIR    - path to configs directory"
  echo "CODES_DIR      - path to codes directory"
  echo "REPO_URL       - url of repo used for dotfiles"     
  echo "REPO_URL_LOCAL - url of repo used for local dotfiles"
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

  echo "$PFX Creating $CODES_DIR: $CODES_DIR"
  mkdir -p $CODES_DIR

  echo "$PFX Creating DOTFILES_DIR: $DOTFILES_DIR"
  mkdir -p $DOTFILES_DIR
}

function runInstallScripts() {
  echo "$PFX Running install scripts..."
  
  $DOTFILES_DIR/bin/install/common/install.sh
  $DOTFILES_DIR/bin/install/$OS/install.sh
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

getAdminPassword
getUserInfo
createDirectories
runInstallScripts

TIMESTAMP_END=$(date)
echo "$PFX Installation started: $TIMESTAMP_START"
echo "$PFX Installation complete: $TIMESTAMP_END"

echo "TODO: Make sure all nvim plugins got installed, open nvim and run:"
echo ":PluginInstall"
echo ":PluginUpdate" 

exit 0
