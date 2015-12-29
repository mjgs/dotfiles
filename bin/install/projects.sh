#!/bin/sh
#
# Description: installs user projects
#
# Env overrides:
# CODES_DIR, GIT_USER, GIT_URL

if [ ! -x /usr/local/bin/git ]; then
  echo "ERROR: Git must be installed to run the projects.sh installer script"
  exit 1
fi

echo "Installing github projects (will not overwrite existing projects)..."
GIT_USER=$GIT_USER && [ ! $GIT_USER ] && GIT_USER=mjgs
GIT_URL=$GIT_URL/$GIT_USER && [ ! $GIT_URL ] && GIT_URL=http://github.com/$GIT_USER

if [ ! -e $CONFIGS_DIR/project_info ]; then
  echo "ERROR: Project info directory must exist to run the project.sh installer script"
  exit 1
fi

for PROJECT in `ls $CONFIGS_DIR/project_info`; do
  if [ -e $CODES_DIR/PROJECT ]; then
    echo "${PROJECT} already exists... Skipping."
  else
    echo "Cloning project $PROJECT..."
    git clone $GIT_URL/$PROJECT.git $CODES_DIR/$PROJECT
  fi
done

if [ -x $CONFIGS_DIR/projects_local.sh ]; then
  $CONFIGS_DIR/projects_local.sh			
fi

exit 0