#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
NAME=${NAME:?}
EMAIL=${EMAIL:?}
SSH_DIR=$HOME/.ssh

echo "$PFX Checking public/private key pair..."

if [ ! -e $SSH_DIR/id_rsa ]; then
  echo "$PFX You don't have a public / private key pair..."
  echo "$PFX Generating public / private key pair..."
  ssh-keygen -t rsa -C $EMAIL
fi
                      
echo "$PFX Your public key:"
cat $SSH_DIR/id_rsa.pub

exit 0
