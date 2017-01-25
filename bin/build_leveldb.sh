#!/bin/bash

set -e

export ROOT_HOME=$(cd `dirname "$0"` && cd .. && pwd)
export LEVELDB_HOME=$(cd $ROOT_HOME && cd vendor/leveldb && pwd)

if [[ "$1" == "clean" ]]; then
  echo --------------------
  echo Clean
  echo --------------------

  cd $LEVELDB_HOME
  git clean -fdx
  git reset --hard
fi


echo --------------------
echo Build LevelDB
echo --------------------

cd $LEVELDB_HOME

make clean all

echo --------------------
echo Copy LevelDB library
echo --------------------

cd $LEVELDB_HOME

if [[ "$OSTYPE" == "darwin"* ]]; then
  LEVELDB_FILE=libleveldb.dylib
  LEVELDB_ARCH=darwin
  OUTPUT_LEVELDB_FILE=
elif [[ "$OSTYPE" == "linux"* ]]; then
  LEVELDB_FILE=libleveldb.so
  if [[ $(uname -m) == "x86_64" ]]; then
    LEVELDB_ARCH=linux-x86-64
  else
    LEVELDB_ARCH=linux-x86
  fi
  OUTPUT_LEVELDB_FILE=
elif [[ "$OSTYPE" == "msys" ]]; then
  LEVELDB_FILE=libleveldb.dll
  if [[ "$MSYSTEM" == "MINGW64" ]]; then
    LEVELDB_ARCH=win32-x86-64
  else
    LEVELDB_ARCH=win32-x86
  fi
  OUTPUT_LEVELDB_FILE=leveldb.dll
fi

mkdir -p $ROOT_HOME/leveldb-jna-native/src/main/resources/$LEVELDB_ARCH/
cp $LEVELDB_FILE $ROOT_HOME/leveldb-jna-native/src/main/resources/$LEVELDB_ARCH/$OUTPUT_LEVELDB_FILE
