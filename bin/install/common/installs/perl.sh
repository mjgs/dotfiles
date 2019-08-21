

#
# Description: installs perl and perl modules
#

if [ -n "$DEBUG" ]; then
  echo "$0: Setting bash option -x for debug"
  PS4='+($(basename ${BASH_SOURCE}):${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# Exit on error
set -e; set -o pipefail

PFX=${PFX:-==>}
HOME=${HOME:?}
LANGUAGES_DIR=${LANGUAGES_DIR:?}
LANGUAGES_PERL_VERSION=${LANGUAGES_PERL_VERSION:?}
DOWNLOAD_URL_BASE=${DOWNLOAD_URL_BASE:-https://www.cpan.org/src}

CWD=$(pwd)
PERL_DIR=$LANGUAGES_DIR/perl
PERL_NAME=perl-$LANGUAGES_PERL_VERSION
PERL_MAJOR_VERSION=$(echo $LANGUAGES_PERL_VERSION | sed 's/\.[^.]*$//' | sed 's/\.[^.]*$//').0
DOWNLOAD_URL=$DOWNLOAD_URL_BASE/$PERL_MAJOR_VERSION/$PERL_NAME.tar.gz
DOWNLOAD_DIR=$PERL_DIR/sources
INSTALL_DIR=$PERL_DIR/versions/$PERL_NAME
BUILT_FILE=$DOWNLOAD_DIR/.$PERL_NAME

MODULES=()

function downloadPerl() {
  echo "$PFX Creating perl environment in directory: $PERL_DIR"
  
  mkdir -p $PERL_DIR/{sources,versions}
  
  echo "$PFX Downloading perl from: $DOWNLOAD_URL"

  local DOWNLOAD_TARGET=$DOWNLOAD_DIR/$PERL_NAME.tar.gz

  echo "$PFX Target: $DOWNLOAD_TARGET"
  
  if [ ! -e "$DOWNLOAD_TARGET" ]; then
    mkdir -p $DOWNLOAD_DIR
    wget $DOWNLOAD_URL -O $DOWNLOAD_TARGET || rm -f $DOWNLOAD_TARGET
  else
    echo "$PFX Download target already exists, skipping..."
  fi

  local UNTARED_TARGET=$(dirname $DOWNLOAD_TARGET)/$PERL_NAME
  
  echo "$PFX Untaring archive: $DOWNLOAD_TARGET"

  # Only untar if the build has never completed yet to ensure
  # the source files aren't overwritten, tar overwrites by default
  if [ ! -e "$BUILT_FILE" ]; then
    tar xvfz $DOWNLOAD_TARGET -C $DOWNLOAD_DIR
  fi
}

function installPerl() {
  cd $DOWNLOAD_DIR/$PERL_NAME

  echo "$PFX Creating install directory: $INSTALL_DIR"
 
  mkdir -p $INSTALL_DIR

  if [ ! -e "$BUILT_FILE" ]; then
    echo "$PFX Configuring..."

    ./Configure -des -Dprefix=$INSTALL_DIR

    echo "$PFX Making..."

    make

    echo "$PFX Testing..."

    make test

    echo "$PFX Installing..."

    make install

    echo "$PFX Creating build file: $BUILT_FILE"

    echo Built: $(date) > $BUILT_FILE
  fi

  cd $CWD
}

function installPerlModules() {
  echo "$PFX Installing perl modules..."

  for MODULE in "${MODULES[@]}"; do
    echo "$PFX Installing perl module: $MODULE"
    cpam $MODULE
  done
}

#
# Main
#

downloadPerl
installPerl
installPerlModules

exit 0
