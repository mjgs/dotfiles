#!/usr/bin/env bash

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
BASH_PROFILE=$HOME/.bash_profile
MONGO_BIN_DIR=/usr/local/opt/mongodb-community@4.0/bin

echo "$PFX Configuring package: mongodb-community"

if ! grep mongodb-community $BASH_PROFILE; then
  echo 'export PATH=$MONGO_BIN_DIR:$PATH"' >> $BASH_PROFILE
fi

exit 0
