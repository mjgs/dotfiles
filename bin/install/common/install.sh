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
REPO_DIR=${REPO_DIR:?}
INSTALLS_DIR=$REPO_DIR/$(dirname $0)/../installs
CONFIGURATIONS_DIR=$REPO_DIR/$(dirname $0)/../configurations

echo "$PFX Installing items common to all os versions"

#
# Main
#

# Configure git and ssh keys since they are needed during the installation
$CONFIGURATIONS_DIR/cli/git.sh
$CONFIGURATIONS_DIR/cli/publicPrivateKeyPair

$INSTALLS_DIR/dotfiles.sh
$INSTALLS_DIR/node.sh

exit 0
