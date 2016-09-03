#!/bin/bash

function usage {
  echo "Usage: $0 -a|-c

Options:
  -a, --all       Build all Docker images
  -c, --changed   Build Docker images that have changed since previous git revision"
}

# only accept one argument
if [ -n "$2" ]; then
  usage
  exit 1
fi

# get images to build based on command line flag
case $1 in
  -a|--all)
    # get all Dockerfiles
    IMAGES=$(git ls-files *Dockerfile)
    ;;
  -c|--changed)
    # get all Dockerfiles that have changed since previous revision
    IMAGES=$(git diff --name-only HEAD^ *Dockerfile)
    ;;
  *)
    usage
    exit 1
    ;;
esac

for i in $IMAGES; do
  # replace / with - to get the docker tag value
  tag=$(dirname $i | sed 's/^fpm\///;s/\//-/g')

  # build each newly changed Dockerfile
  echo "Building colinhoglund/fpm:${tag} image from ${i}:"
  cd $(dirname $(git rev-parse --show-toplevel)/$i)
  docker build -t colinhoglund/fpm:${tag} .
done
