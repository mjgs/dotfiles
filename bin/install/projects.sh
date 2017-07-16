#!/bin/sh
#
# Description: installs user projects
#
# Env overrides:
# CONFIGS_DIR, CODES_DIR, REPO_URL

if [ ! $CONFIGS_DIR ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! $CODES_DIR ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! $REPO_URL ]; then
  echo ERROR: CONFIGS_DIR environment variable is not defined
  exit 1
fi

if [ ! -x /usr/local/bin/git ]; then
  echo "ERROR: Git must be installed to run the projects.sh installer script"
  exit 1
fi

echo "Installing github projects (will not overwrite existing projects)..."
if [ ! -e $CONFIGS_DIR/project_info ]; then
  echo "ERROR: Project info directory must exist to run the project.sh installer script"
  exit 1
fi

for PROJECT in `ls $CONFIGS_DIR/project_info`; do
  if [ -e $CODES_DIR/PROJECT ]; then
    echo "${PROJECT} already exists... Skipping."
  else
    echo "Cloning project $PROJECT..."
    git clone $REPO_URL/$PROJECT.git $CODES_DIR/$PROJECT
  fi
done

if [ -x $CONFIGS_DIR/projects_local.sh ]; then
  $CONFIGS_DIR/projects_local.sh			
fi

exit 0