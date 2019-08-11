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

echo "$PFX Checking public/private key pair..."

SSH_DIR=$HOME/.ssh

mkdir -p $SSH_DIR

if [ ! -e $SSH_DIR ]; then
  echo "$PFX You don't have a public / private key pair..."
  echo "$PFX Generating public / private key pair..."
  ssh-keygen -f $SSH_DIR/id_rsa -t rsa -C $EMAIL
fi

exit 0
