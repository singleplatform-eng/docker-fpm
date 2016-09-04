#!/bin/bash

GIT_ROOT=$(git rev-parse --show-toplevel)

function usage {
  echo "Usage: $0 -a|-c|dockerfile

Options:
  -a, --all       Build all Docker images
  -c, --changed   Build Docker images that have changed since previous git revision"

  exit 1
}

# only accept one argument
if [ -n "$2" ]; then
  usage
fi

# get images to build based on command line flag
case $1 in
  -a|--all)
    # get all Dockerfiles
    IMAGES=$(git ls-files *Dockerfile)
    ;;
  -c|--changed)
    # get all Dockerfiles that have changed since previous revision
    IMAGES=$(git diff --diff-filter=ACMR --name-only HEAD^ *Dockerfile)
    ;;
  *)
    # check that dockerfile exists
    if [ -n "$1" ] && [ -f ${GIT_ROOT}/${1} ]; then
      # set images to specified docker file
      IMAGES=$1
    else
      usage
    fi
    ;;
esac

for i in $IMAGES; do
  # replace / with - to get the docker tag value
  tag=$(dirname $i | sed 's/\//-/g')

  # build each newly changed Dockerfile
  echo "Building colinhoglund/fpm:${tag} image from ${i}:"
  cd $(dirname ${GIT_ROOT}/${i})
  docker build -t colinhoglund/fpm:${tag} .
done
