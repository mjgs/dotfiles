#!/bin/sh
#
# Description: Deletes dotfile symlinks

echo "Deleting ~/ dotfile symlinks..."

LINKABLES=$( find -H "$CONFIGS_DIR" -maxdepth 3 -name '*.symlink' )

for FILE in $LINKABLES; do
  TARGET="$HOME/.$( basename $FILE ".symlink" )"
  if [ -e $TARGET ]; then
    echo "Deleting ${TARGET} symlink to $FILE"
    rm $TARGET
  fi
done

echo "Deleting ~/.config dotfile symlinks..."
if [ ! -d $HOME/.config ]; then
  exit 0
fi

CONFIGS=$( find -H "$DOTFILES_DIR/config" -maxdepth 1 -name '*.symlink' )

for CONFIG in $CONFIGS; do
  TARGET="$HOME/.config/$( basename $CONFIG ".symlink" )"
  if [ -e $TARGET ]; then
    echo "Deleting ~${TARGET#$HOME} symlink to $CONFIG"
    rm $TARGET
  fi
done

exit 0