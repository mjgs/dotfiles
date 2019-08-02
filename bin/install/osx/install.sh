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

if [ ! -x /usr/bin/gcc ]; then
  echo "$PFX Installing xcode..."
  xcode-select --install
fi

echo "$PFX Installing OSX items"

./installs/brew.sh
./installs/gui.sh
./installs/ruby.sh
./installs/python.sh
./installs/shell.sh

echo "$PFX Configuring OSX settings and applications"

../configurations/system/set_system_prefs.sh
../configurations/system/set_hidden_prefs.sh
../configurations/system/set_application_prefs.sh
../configurations/system/configure_dock_apps.sh

exit 0
