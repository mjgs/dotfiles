#!/usr/bin/env bash

#
# Description: configures OSX items 
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

DOTFILES_DIR=${DOTFILES_DIR:?}

function configureOsxSettingsAndApps() {
  echo "$PFX Configuring OSX settings and applications"

  $DOTFILES_DIR/bin/install/common/configurations/set_system_prefs.sh
  $DOTFILES_DIR/bin/install/common/configurations/set_hidden_prefs.sh
  $DOTFILES_DIR/bin/install/common/configurations/set_application_prefs.sh
  $DOTFILES_DIR/bin/install/common/configurations/configure_dock_apps.sh
}

function configure3rdPartyApps() {
  echo "$PFX Configuring OSX 3rd party application"

  $DOTFILES_DIR/bin/install/common/configurations/cli-configuration.sh
  $DOTFILES_DIR/bin/install/common/configurations/gui-configuration.sh
}

#
# Main
#

configureOsxSettingsAndApps
configure3rdPartyApps

exit 0
