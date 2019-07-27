#!/usr/bin/env bash

#
# Description: installs items common to all os installations
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
EMAIL=${EMAIL:?}
HOME=${HOME:?}

echo "$PFX Installing items common to all os versions"

function configureGit() {
  echo "$PFX Configuring git..."
  
  git config --global user.name $NAME
  git config --global user.email $EMAIL
  git config --global push.default simple
  git config --global core.excludesfile '$HOME/.gitignore'
}

function createPublicPrivateKeyPair() {
  echo "$PFX Checking public/private key pair..."

  if [ ! -e $HOME/.ssh/id_rsa ]; then
    echo "$PFX You don't have a public / private key pair..."
    echo "$PFX Generating public / private key pair..."
    ssh-keygen -t rsa -C $EMAIL
  fi

  echo "$PFX Your public key:"
  cat $HOME/.ssh/id_rsa.pub
}

#
# Main
#

configureGit
createPublicPrivateKeyPair

$DOTFILES/bin/install/common/installs/dotfiles.sh
$DOTFILES/bin/install/common/installs/node.sh

exit 0
