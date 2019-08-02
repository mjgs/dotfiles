#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}

echo "$PFX Configuring package: redis"

if which redis-server > /dev/null; then
  brew services start redis
else
  echo "ERROR: redis must be installed"
  exit 1
fi

exit 0
