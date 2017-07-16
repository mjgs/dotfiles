#!/bin/sh
#
# Description: installs dotfiles

if [ ! $CONFIGS_DIR ]; then 
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi	

if [ ! $CODES_DIR ]; then 
  echo ERROR: CODES_DIR environment variable is not defined
  exit 1
fi

if [ ! -e $DOTFILES_DIR ]; then 
  echo ERROR: Dotfiles directory does not exist
  exit 1
fi	

echo "Creating ~/ dotfile symlinks..."

LINKABLES=$( find -H "$CONFIGS_DIR" -maxdepth 3 -name '*.symlink' )

for FILE in $LINKABLES; do
  TARGET="$HOME/.$( basename $FILE ".symlink" )"
  if [ -e $TARGET ]; then
    echo "${TARGET} already exists... Skipping."
  else
    echo "Creating $TARGET symlink to $FILE"
    ln -s $FILE $TARGET
  fi
done

echo "Creating XDG ~/.config dotfile symlinks..."
# XDG Base Directory Specification: 
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
if [ ! -d $HOME/.config ]; then
  echo "Creating ~/.config"
  mkdir -p $HOME/.config
fi

CONFIGS=$( find -H "$DOTFILES_DIR/dotfiles/config" -maxdepth 1 -name '*.symlink' )

for CONFIG in $CONFIGS; do
  TARGET="$HOME/.config/$( basename $CONFIG ".symlink" )"
  if [ -e $TARGET ]; then
    echo "~${TARGET#$HOME} already exists... Skipping."
  else
    echo "Creating $TARGET symlink to $CONFIG"
    ln -s $CONFIG $TARGET
  fi
done

if [ -x $CONFIGS_DIR/dotfiles_local.sh ]; then
  $CONFIGS_DIR/dotfiles_local.sh			
fi

exit 0