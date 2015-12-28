#!/bin/sh
#
# Description: installs ruby and ruby packages

if [ ! -x /usr/local/bin/brew ]; then
	echo "ERROR: Homebrew must be installed to run the ruby.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/bin/ruby ]; then
  echo "Installing ruby..."
  brew install ruby
  source $HOME/.zshrc
  sleep 2
fi

echo "Current ruby: `which ruby`"
echo "Current rubygems: `which gem`"

echo "Installing ruby packages..."

gem install -N compass
gem install -N genghisapp
gem install -N bson_ext
gem install -N jekyll
gem install -N sass
gem install -N rouge

source $HOME/.zshrc

if [ -x $CONFIGS_DIR/ruby_local.sh ]; then
  $CONFIGS_DIR/ruby_local.sh			
fi

exit 0