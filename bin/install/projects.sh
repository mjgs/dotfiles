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
  echo ERROR: CODES_DIR environment variable is not defined
  exit 1
fi

if [ ! $REPO_URL ]; then
  echo ERROR: REPO_URL environment variable is not defined
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

for PROJECT_NAME in `ls $CONFIGS_DIR/project_info`; do
  if [ -e $CODES_DIR/projects/$PROJECT_NAME ]; then
    echo "${PROJECT_NAME} already exists... Skipping."
  else
    echo "Cloning project $PROJECT_NAME..."
    git clone $REPO_URL/$PROJECT_NAME.git $CODES_DIR/projects/$PROJECT_NAME
  fi
done

if [ -x $CONFIGS_DIR/projects_local.sh ]; then
  $CONFIGS_DIR/projects_local.sh			
fi

exit 0
