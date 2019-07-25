#!/bin/sh
#
# Description: installs ruby and ruby packages

if [ ! $CONFIGS_DIR ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the ruby.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/bin/ruby ]; then
  echo "Installing ruby..."
  brew install ruby
fi

echo "Current ruby: `which ruby`"
echo "Current rubygems: `which gem`"

echo "Installing ruby packages..."
# gem install -N [ruby app]
gem install jekyll bundler

if [ -x $CONFIGS_DIR/ruby_local.sh ]; then
  $CONFIGS_DIR/ruby_local.sh			
fi

exit 0
