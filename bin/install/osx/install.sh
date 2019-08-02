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
INSTALLS_DIR=$REPO_DIR/$(dirname $0)/../installs
CONFIGURATIONS_DIR=$REPO_DIR/$(dirname $0)/../configurations

if [ ! -x /usr/bin/gcc ]; then
  echo "$PFX Installing xcode..."
  xcode-select --install
fi

echo "$PFX Installing OSX items"

$INSTALLS_DIR/brew.sh
$INSTALLS_DIR/gui.sh
$INSTALLS_DIR/ruby.sh
$INSTALLS_DIR/python.sh
$INSTALLS_DIR/shell.sh

echo "$PFX Configuring OSX settings and applications"

$CONFIGURATIONS_DIR/system/set_system_prefs.sh
$CONFIGURATIONS_DIR/system/set_hidden_prefs.sh
$CONFIGURATIONS_DIR/system/set_application_prefs.sh
$CONFIGURATIONS_DIR/system/configure_dock_apps.sh

exit 0
