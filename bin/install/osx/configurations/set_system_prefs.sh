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

# General
# Desktop and screensaver
# Dock
# Mission control
# Language and region
# Security and privacy
# Spotlight
# Notifications

# Universal access ?
# CDs & DVDs ? (Sharing ?)

# Displays
# Energy saver
# Keyboard
# Mouse
# Trackpad
# Printers and scanners
# Sound

# iCloud
# Internet accounts
# Extensions
# Network
# Bluetooth
# Sharing

# Users and groups
# Parental control
# App store
# Dictation and speech
# Date & time
# Startup disk
# Softare update ? (App store - check for app store updates ?)
# Speech ? (Dictation and speech ?)
# Time machine
# Accessibility

exit 0
