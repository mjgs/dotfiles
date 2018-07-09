#!/bin/sh
#
# Description: sets up a fake local git, used for testing project.sh

GIT_USER=$GIT_USER && [ ! $GIT_USER ] && GIT_USER=mjgs
GIT_DIR=$GIT_URL/$GIT_USER && [ ! $GIT_URL ] && GIT_URL=/tmp/fake-git-projects

if [ ! -e $GIT_DIR ]; then
  echo "Creating directory: $GIT_DIR"
  mkdir -p $GIT_DIR
fi

echo "Fake git directory: $GIT_DIR"

cd $GIT_DIR

echo "Creating fake git projects..."
for PROJECT_NAME in `ls $CONFIGS_DIR/project_info`; do
  echo "Creating fake git project: $PROJECT_NAME.git"
  echo "mkdir $PROJECT_NAME.git && cd $PROJECT_NAME.git"
  mkdir $PROJECT_NAME.git && cd $PROJECT_NAME.git
  git init
  touch testfile
  git add .
  git commit -m "Initial files"
  cd $GIT_DIR
done

echo "Done creating fake git projects:"
tree $GIT_DIR

exit 0
