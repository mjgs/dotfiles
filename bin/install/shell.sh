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
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing bullet-train oh-my-zsh theme..."
URL=https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
mkdir -p $ZSH/custom/themes
wget -P $ZSH/custom/themes/ $URL

if [ -x $CONFIGS_DIR/shell_local.sh ]; then
  $CONFIGS_DIR/shell_local.sh			
fi

exit 0