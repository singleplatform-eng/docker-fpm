#!/bin/bash

GIT_ROOT=$(git rev-parse --show-toplevel)

function usage {
    echo "Usage: $0 -a|-c|-tdockerfile

Options:
    -a, --all       Build all Docker images
    -c, --changed   Build Docker images that have changed since previous git revision
    -h, --help      Show this help message
    -p, --publish   Publish containers"
}

function update_travis_build_matrix {
    travis_file=$GIT_ROOT/.travis.yml
    touch $travis_file

    # .travis.yml pre-config
    echo 'sudo: required

# skip language installation steps for docker builds
install: true

services:
    - docker

env:' > $travis_file

    # append images/scripts to test
    travis_tests=$(git ls-files | egrep 'Dockerfile|build_scripts')
    for t in $travis_tests; do
        echo "    - TEST: ${t}" >> $travis_file
    done

    # .travis.yml post-config
    printf "\nscript: ./tests.sh\n" >> $travis_file
}


# get images to build based on command line flag
for var in $@; do
    case $var in
        -a|--all)
            # get all Dockerfiles
            IMAGES=$(git ls-files *Dockerfile)
            shift
            ;;
        -c|--changed)
            # get all Dockerfiles that have changed since previous revision
            IMAGES=$(git diff --diff-filter=ACMR --name-only HEAD^ *Dockerfile)
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        -p|--publish)
            PUBLISH=0
            shift
            ;;
        *)
            shift
            ;;
    esac
done
if [ -n $IMAGES ]; then $(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION); fi
for i in $IMAGES; do
  # replace / with - to get the docker tag value
  tag=$(dirname $i | sed 's/\//-/g')

  # build each newly changed Dockerfile
  echo "Building fpm:${tag} image from ${i}:"
  cd $(dirname ${GIT_ROOT}/${i})
  docker build -t fpm:${tag} .
  echo "Publish: $PUBLISH"
  if [ $PUBLISH ]; then
      echo "Publishing ${tag}"
      docker tag fpm:${tag} $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/fpm:${tag}
      docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/fpm:${tag}
  fi
done
