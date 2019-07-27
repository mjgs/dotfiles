#!/bin/sh

#
# Description: installs shell
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
CONFIGS_DIR=${CONFIGS_DIR:?}

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the shell.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/bin/bash ]; then
  echo "$PFX Installing latest bash version..."
  brew install bash
  echo /usr/local/bin/bash >> /private/etc/shells
  chsh -s /usr/local/bin/bash
fi

if [ -x $CONFIGS_DIR/shell_local.sh ]; then
  $CONFIGS_DIR/shell_local.sh			
fi

exit 0
