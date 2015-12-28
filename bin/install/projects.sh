#!/bin/sh
#
# Description: installs user projects

if [ ! -x /usr/local/bin/git ]
then
  echo "ERROR: Git must be installed to run the projects.sh installer script"
  exit 1
fi

echo "Installing user projects (will not overwrite existing projects)..."
if [ ! -e $CODES_DIR/routes_builder ]; then git clone http://github.com/mjgs/routes_builder.git $CODES_DIR; fi
#if [ ! -e $CODES_DIR/routes_builder ];then git clone http://github.com/mjgs/routes_builder.git $CODES_DIR; fi

if [ -x $CONFIGS_DIR/projects_local.sh ]
then
  $CONFIGS_DIR/projects_local.sh			
fi

exit 0