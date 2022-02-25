#!/bin/sh
#
# Shell script to restore the H2 Repository and Archive Database
#

absdirname ()
{
  _dir="`dirname \"$1\"`"
  cd "$_dir"
  echo "`pwd`"
}

resolvelink() {
  _dir=`dirname "$1"`
  _dest=`readlink "$1"`
  case "$_dest" in
  /* ) echo "$_dest" ;;
  *  ) echo "$_dir/$_dest" ;;
  esac
}

# Get Java executable
if [ -z "$JAVA_HOME" ] ; then
  JAVACMD=java
else
  JAVACMD="${JAVA_HOME}/bin/java"
fi

# Get XL Release server home dir
if [ -z "$XL_RELEASE_SERVER_HOME" ] ; then
  self="$0"
  if [ -h "$self" ]; then
    self=`resolvelink "$self"`
  fi
  BIN_DIR=`absdirname "$self"`
  XL_RELEASE_SERVER_HOME=`dirname "$BIN_DIR"`
elif [ ! -d "$XL_RELEASE_SERVER_HOME" ] ; then
  echo "Directory $XL_RELEASE_SERVER_HOME does not exist"
  exit 1
fi

cd "$XL_RELEASE_SERVER_HOME"

H2_CLASSPATH="$XL_RELEASE_SERVER_HOME/lib/*"
RESTORE_SCRIPT="org.h2.tools.RunScript"

# Default db is repository. For Archive db, pass explicit argument -db archive
DB_NAME="repository"
ARGS="$*"
DB_ARCHIVE="-db archive"
# DB_ARCHIVE is present when args != (args with substring $DB_ARCHIVE removed)
# Equivalent to this in bash shell [[ "$@" =~ '-db archive' ]] && DB_NAME="archive"
if [ "$ARGS" != "${ARGS%"$DB_ARCHIVE"*}" ]; then
    DB_NAME="archive"
fi

# Run restore script
$JAVACMD -classpath "${H2_CLASSPATH}" "$RESTORE_SCRIPT" \
-url jdbc:h2:file:$XL_RELEASE_SERVER_HOME/$DB_NAME/db \
-user sa \
-script $XL_RELEASE_SERVER_HOME/backup-$DB_NAME.zip \
-options compression zip QUIRKS_MODE VARIABLE_BINARY;

rm -rf $XL_RELEASE_SERVER_HOME/backup-$DB_NAME.zip;
