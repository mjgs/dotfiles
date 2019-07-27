#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}

#
# Main
#

# /System/Library/CoreServices/Finder
# /System/Library/CoreServices/HelpViewer
# /System/Library/CoreServices/ReportCrash
# /System/Library/CoreServices/SystemUIServer

# Move into set_system_prefs: ?
# System Preferences > Users & Groups > Login Items
# System Preferences > Growl
# System Preferences > Choosy

# Applications: iTunes
# Applications: Mail
# Applications: Quicktime Player
# Applications: Remote Destop
# Applications: Safari
# Applications: Skype
# Applications: Total Finder
# Applications: Transmission
# Applications: VMWare Fusion
# etc

# Utilities: Audio Hijack Pro
# Utilities: Disk Utility
# Utilities: Dropbox
# Utilities: Handbrake

exit 0
