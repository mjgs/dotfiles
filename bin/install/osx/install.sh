#!/bin/sh

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

echo "########################################################################"
echo "#                       Installing items for OSX                       #"
echo "########################################################################"

CWD=$(pwd)
CONFIGS_DIR=${CONFIGS_DIR:?}
CODES_DIR=${CODES_DIR:?}
DOTFILES_DIR=${DOTFILES_DIR:?}

if [ ! -x /usr/bin/gcc ]; then
  echo "Installing xcode..."
  xcode-select --install
fi

if [ ! -x /usr/bin/git ]; then
  echo "ERROR: Apple's version of git must be installed" 
  exit 1
fi

echo "########################################################################"
echo "#                     OSX: Installing cli utilities                    #"
echo "########################################################################"

$DOTFILES_DIR/bin/install/osx/brew.sh
$DOTFILES_DIR/bin/install/osx/ruby.sh
$DOTFILES_DIR/bin/install/osx/python.sh
$DOTFILES_DIR/bin/install/osx/shell.sh

echo "########################################################################"
echo "#                       OSX: Configuring settings                      #"
echo "########################################################################"

$DOTFILES_DIR/bin/osx/set_system_prefs.sh
$DOTFILES_DIR/bin/osx/set_hidden_prefs.sh
$DOTFILES_DIR/bin/osx/set_application_prefs.sh
$DOTFILES_DIR/bin/osx/configure_dock_apps.sh

echo "########################################################################"
echo "#                    OSX: Configuring GUI applications                 #"
echo "########################################################################"

$DOTFILES_DIR/bin/install/osx/gui.sh
$DOTFILES_DIR/bin/install/osx/gui-configuration.sh

exit 0
