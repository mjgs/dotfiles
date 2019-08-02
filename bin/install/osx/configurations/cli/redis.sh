#!/usr/bin/env bash

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
