#!/usr/bin/env bash

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}

# Run the common configuration
../../../common/configurations/cli/neovim.sh

exit 0
