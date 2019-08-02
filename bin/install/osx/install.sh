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
BASE_DIR=${BASE_DIR:?}
INSTALLS_DIR=$DOTFILES_DIR/$(dirname $0)/../installs
CONFIGURATIONS_DIR=$DOTFILES_DIR/$(dirname $0)/../configurations

if [ ! -x /usr/bin/gcc ]; then
  echo "$PFX Installing xcode..."
  xcode-select --install
fi

echo "$PFX Installing OSX items"

$BASE_DIR/bin/install/osx/installs/brew.sh
$BASE_DIR/bin/install/osx/installs/gui.sh
$BASE_DIR/bin/install/osx/installs/ruby.sh
$BASE_DIR/bin/install/osx/installs/python.sh
$BASE_DIR/bin/install/osx/installs/shell.sh

echo "$PFX Configuring OSX settings and applications"

$BASE_DIR/bin/install/osx/configurations/system/set_system_prefs.sh
$BASE_DIR/bin/install/osx/configurations/system/set_hidden_prefs.sh
$BASE_DIR/bin/install/osx/configurations/set_application_prefs.sh
$BASE_DIR/bin/install/osx/configurations/system/configure_dock_apps.sh

exit 0
