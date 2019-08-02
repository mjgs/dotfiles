#!/usr/bin/env bash

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
NAME=${NAME:?}
EMAIL=${EMAIL:?}

echo "$PFX Configuring package: git"

echo "$PFX Setting git user.name: $NAME"
git config --global user.name \"$NAME\"

echo "$PFX Setting git user.email: $EMAIL"
git config --global user.email $EMAIL

echo "$PFX Setting git push.default: simple"
git config --global push.default simple

echo "$PFX Setting git core.excludesfile: $HOME/.gitignore"
git config --global core.excludesfile '$HOME/.gitignore'

exit 0
