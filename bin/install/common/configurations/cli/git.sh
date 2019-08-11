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

GITCONFIG=$HOME/.gitconfig

echo "$PFX Configuring package: git"

mkdir -p $(dirname $GITCONFIG)
touch $GITCONFIG

if ! git config user.name > /dev/null; then
  echo "$PFX Setting git user.name: $NAME"
  git config --global user.name "$NAME"
fi

if ! git config user.email > /dev/null; then
  echo "$PFX Setting git user.email: $EMAIL"
  git config --global user.email "$EMAIL"
fi

if ! git config push.default > /dev/null; then
  echo "$PFX Setting git push.default: simple"
  git config --global push.default simple
fi

if ! git config core.excludefile > /dev/null; then
  echo "$PFX Setting git core.excludesfile: ~/.gitignore"
  git config --global core.excludesfile \~/.gitignore
fi

exit 0
