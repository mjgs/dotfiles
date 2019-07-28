#!/usr/bin/env bash

#
# Description: installs osx items 
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
REPO_DIR=${REPO_DIR:?}

if [ ! -x /usr/bin/gcc ]; then
  echo "$PFX Installing xcode..."
  xcode-select --install
fi

if [ ! -x /usr/bin/git ]; then
  echo "ERROR: Apple's version of git must be installed" 
  exit 1
fi

echo "$PFX Installing OSX items"

$REPO_DIR/bin/install/osx/installs/brew.sh
$REPO_DIR/bin/install/osx/installs/gui.sh
$REPO_DIR/bin/install/osx/installs/ruby.sh
$REPO_DIR/bin/install/osx/installs/python.sh
$REPO_DIR/bin/install/osx/installs/shell.sh

exit 0
