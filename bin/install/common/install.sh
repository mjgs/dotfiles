#!/bin/sh

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

echo "$PFX Installing items common to all os versions"

CWD=$(pwd)
CONFIGS_DIR=${CONFIGS_DIR:?}
CODES_DIR=${CODES_DIR:?}
DOTFILES_DIR=${DOTFILES_DIR:?}

echo "$PFX Checking public/private key pair..."

if [ ! -e $HOME/.ssh/id_rsa ]; then
  echo "$PFX You don't have a public / private key pair..."
  echo "$PFX Generating public / private key pair..."
  ssh-keygen -t rsa -C $EMAIL
fi

echo "$PFX Your public key:"
cat $HOME/.ssh/id_rsa.pub

$DOTFILES/bin/install/common/dotfiles.sh
$DOTFILES/bin/install/common/node.sh

exit 0
