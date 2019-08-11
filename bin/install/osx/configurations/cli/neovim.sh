#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
DOTFILES_DIR=${DOTFILES_DIR:?}

# Run the common configuration
$DOTFILES_DIR/bin/install/common/configurations/cli/neovim.sh

exit 0
