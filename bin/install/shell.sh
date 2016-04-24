#!/bin/sh
#
# Description: installs shell

if [ ! -x /usr/local/bin/brew ]; then
  echo "ERROR: Homebrew must be installed to run the shell.sh installer script"
  exit 1
fi

if [ ! -x /usr/local/bin/zsh ]; then
  echo "Installing zsh..."
  brew install zsh
fi

echo "Installing oh-my-zsh..."
# Use manual instalation method - clone repo, then change shell
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh

echo "Installing bullet-train oh-my-zsh theme..."
git clone https://github.com/amandeepg/bullet-train-oh-my-zsh-theme.git /tmp/bullet-train-oh-my-zsh-theme
mkdir -p ~/.oh-my-zsh/themes
mv /tmp/bullet-train-oh-my-zsh-theme/bullet-train.zsh-theme ~/.oh-my-zsh/themes
rm -rf /tmp/bullet-train-oh-my-zsh-theme

if [ -x $CONFIGS_DIR/shell_local.sh ]; then
  $CONFIGS_DIR/shell_local.sh			
fi

exit 0
