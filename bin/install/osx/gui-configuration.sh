#!/bin/sh

#
# Description: configures installed gui apps
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
 
# Run gui-configuration.sh after all items have been installed since some
# configuration requires that certain environments are installed.

# Homebrew packages
echo "$PFX Configuring installed homebrew cask packages..."

exit 0
