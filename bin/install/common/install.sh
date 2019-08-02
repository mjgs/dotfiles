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
BASE_DIR=${BASE_DIR:?}

echo "$PFX Installing items common to all os versions"

#
# Main
#

# Configure git and ssh keys since they are needed during the installation
$BASE_DIR/bin/install/common/configurations/cli/git.sh
$BASE_DIR/bin/install/common/configurations/cli/publicPrivateKeyPair.sh

$BASE_DIR/bin/install/common/installs/dotfiles.sh
$BASE_DIR/bin/install/common/installs/node.sh

exit 0
