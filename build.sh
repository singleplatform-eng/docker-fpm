#!/bin/bash

GIT_ROOT=$(git rev-parse --show-toplevel)

function usage {
    echo "Usage: $0 -a|-c|-tdockerfile

Options:
    -a, --all       Build all Docker images
    -c, --changed   Build Docker images that have changed since previous git revision
    -h, --help      Show this help message
    -t, --travis    Update .travis.yml build matrix"
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
        IMAGES=$(git diff --diff-filter=ACMR --name-only HEAD^ *Dockerfile)
        ;;
    -h|--help)
        usage
        exit 0
        ;;
    -t|--travis)
        update_travis_build_matrix
        exit 0
        ;;
    *)
        # check that dockerfile exists
        if [ -n "$1" ] && [ -f ${GIT_ROOT}/${1} ]; then
            # set images to specified docker file
            IMAGES=$1
        else
            usage
            exit 1
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
