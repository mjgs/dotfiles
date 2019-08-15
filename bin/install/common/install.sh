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
HOME=${HOME:?}
DOTFILES_DIR=${DOTFILES_DIR:?}

echo "$PFX Installing items common to all os versions"

#
# Main
#

$DOTFILES_DIR/bin/install/common/installs/dotfiles.sh
$DOTFILES_DIR/bin/install/common/installs/node.sh
$DOTFILES_DIR/bin/install/common/installs/perl.sh

exit 0
