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
NAME=${NAME:?}
EMAIL=${EMAIL:?}
HOME=${HOME:?}
REPO_DIR=${REPO_DIR:?}

echo "$PFX Installing items common to all os versions"

# Configure git here since it's needed during the installation
function configureGit() {
  echo "$PFX Configuring git..."
  
  echo "$PFX Setting git user.name: $NAME"
  git config --global user.name \"$NAME\"

  echo "$PFX Setting git user.email: $EMAIL"
  git config --global user.email $EMAIL

  echo "$PFX Setting git push.default: simple"
  git config --global push.default simple

  echo "$PFX Setting git core.excludesfile: $HOME/.gitignore"
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
