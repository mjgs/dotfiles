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

REPO_DIR=${REPO_DIR:?}

function configureOsxSettingsAndApps() {
  echo "$PFX Configuring OSX settings and applications"

  $REPO_DIR/bin/install/osx/configurations/set_system_prefs.sh
  $REPO_DIR/bin/install/osx/configurations/set_hidden_prefs.sh
  $REPO_DIR_DIR/bin/install/osx/configurations/set_application_prefs.sh
  $REPO_DIR/bin/install/osx/configurations/configure_dock_apps.sh
}

#
# Main
#

configureOsxSettingsAndApps

exit 0
