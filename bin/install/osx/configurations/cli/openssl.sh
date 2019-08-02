#!/usr/bin/env bash

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
BASH_PROFILE=$HOME/.bash_profile

echo "$PFX Configuring package: openssl"

echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> $BASH_PROFILE

exit 0
