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

echo "########################################################################"
echo "#               Installing items common to all os versions             #"
echo "########################################################################"

CWD=$(pwd)
CONFIGS_DIR=${CONFIGS_DIR:?}
CODES_DIR=${CODES_DIR:?}
DOTFILES_DIR=${DOTFILES_DIR:?}

echo "Checking public/private key pair..."

if [ -e ~/.ssh/id_rsa ]; then
  echo "Your public key:"
  cat ~/.ssh/id_rsa.pub
else
  echo "You don't have a public / private key pair..."
  ssh-keygen -t rsa -C $EMAIL
  
  echo "Your public key:"
  cat ~/.ssh/id_rsa.pub
fi

$DOTFILES/bin/install/common/dotfiles.sh
$DOTFILES/bin/install/common/node.sh

exit 0
