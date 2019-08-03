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

PFX=${PFX:-==>}
REPO_DIR=${REPO_DIR:?}

if [ ! -x /usr/bin/gcc ]; then
  echo "$PFX Installing xcode..."
  xcode-select --install
fi

echo "$PFX Installing OSX items"

$REPO_DIR/bin/install/osx/installs/ruby.sh
$REPO_DIR/bin/install/osx/installs/python.sh
$REPO_DIR/bin/install/osx/installs/shell.sh
$REPO_DIR/bin/install/osx/installs/brew.sh
$REPO_DIR/bin/install/osx/installs/gui.sh

echo "$PFX Configuring OSX settings and applications"

$REPO_DIR/bin/install/osx/configurations/system/set_system_prefs.sh
$REPO_DIR/bin/install/osx/configurations/system/set_hidden_prefs.sh
$REPO_DIR/bin/install/osx/configurations/set_application_prefs.sh
$REPO_DIR/bin/install/osx/configurations/system/configure_dock_apps.sh

exit 0
