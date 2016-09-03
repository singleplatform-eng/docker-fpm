#!/bin/bash

# get all Dockerfiles that have changed
CHANGED_IMAGES=$(git diff --name-only HEAD^ | grep Dockerfile)

for i in $CHANGED_IMAGES; do
  fullpath=$(git rev-parse --show-toplevel)/$i
  # replace / with - to get the docker tag value
  tag=$(dirname $i | sed 's/^fpm\///;s/\//-/g')

  # build each newly changed Dockerfile
  echo "Building colinhoglund/fpm:${tag} image from ${i}:"
  cd $(dirname ${fullpath})
  docker build -t colinhoglund/fpm:${tag} .
  cd - &> /dev/null
done
