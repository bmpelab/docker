#!/bin/bash
if [ $# != 1 ]; then
  echo "build.sh [target dir]"
  exit 1
else
  TARGET_DIR=$(cd $1; pwd)
  TAG_NAME=`echo $TARGET_DIR | sed -e 's/.*\/\([^\/]*\)$/\1/'`
  IMAGE_NAME=`echo $(cd $TARGET_DIR/; cd ../; pwd) | sed -e 's/.*\/\([^\/]*\)$/\1/'`
  echo "docker build $TARGET_DIR -t bmpelab/$IMAGE_NAME:$TAG_NAME"
  docker build $TARGET_DIR -t bmpelab/$IMAGE_NAME:$TAG_NAME
fi
