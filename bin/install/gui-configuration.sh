#!/bin/sh
#
# Description: configures installed gui apps
# 
# Run gui-configuration.sh after all items have been installed since some
# configuration requires that certain environments are installed.

# Homebrew packages
echo "Configuring installed homebrew cask packages..."

echo "Configuring webstorm..."
version=`brew cask info webstorm | grep webstorm\: | awk '{split($0,a," "); print a[2]}'`
echo "Webstorm version: $version"
dir=~/Library/Preferences/WebStorm$version/colors
base="https://raw.githubusercontent.com/jkaving/intellij-colors-solarized/master"
echo "Downloading solarized dark colorscheme"
wget $base/Solarized%20Dark.icls -P $dir
echo "Downloading solarized light colorscheme"
wget $base/Solarized%20Light.icls -P $dir
