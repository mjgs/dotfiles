#!/bin/sh

#
# Description: installs ruby and ruby packages
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
CONFIGS_DIR=${CONFIGS_DIR:?}

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the ruby.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/bin/ruby ]; then
  echo "$PFX Installing ruby..."
  brew install ruby
fi

echo "$PFX Current ruby: `which ruby`"
echo "$PFX Current rubygems: `which gem`"

echo "$PFX Installing ruby packages..."
# gem install -N [ruby app]
gem install jekyll bundler

if [ -x $CONFIGS_DIR/ruby_local.sh ]; then
  $CONFIGS_DIR/ruby_local.sh			
fi

exit 0
