#!/usr/bin/env bash

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
BASE_DIR=${BASE_DIR:?}

# Run the common configuration
$BASE_DIR/bin/install/common/configurations/cli/neovim.sh

exit 0
