#!/bin/sh

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

echo "$PFX Installing items for OSX"

CWD=$(pwd)
PFX=${PFX:-==>}
CONFIGS_DIR=${CONFIGS_DIR:?}
CODES_DIR=${CODES_DIR:?}
DOTFILES_DIR=${DOTFILES_DIR:?}

if [ ! -x /usr/bin/gcc ]; then
  echo "$PFX Installing xcode..."
  xcode-select --install
fi

if [ ! -x /usr/bin/git ]; then
  echo "ERROR: Apple's version of git must be installed" 
  exit 1
fi

echo "$PFX Installing OSX items"

$DOTFILES_DIR/bin/install/osx/installs/brew.sh
$DOTFILES_DIR/bin/install/osx/installs/gui.sh
$DOTFILES_DIR/bin/install/osx/installs/ruby.sh
$DOTFILES_DIR/bin/install/osx/installs/python.sh
$DOTFILES_DIR/bin/install/osx/installs/shell.sh

exit 0