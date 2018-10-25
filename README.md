[![Build Status](https://travis-ci.org/colinhoglund/docker-fpm.svg?branch=master)](https://travis-ci.org/colinhoglund/docker-fpm)

# docker-fpm
Use [fpm](https://github.com/jordansissel/fpm) inside [Docker](https://www.docker.com/) containers to easily build various OS packages.

Pre-built images can be pulled from [hub.docker.com](https://hub.docker.com/r/colinhoglund/fpm/).

## Requirements
- [Docker](https://www.docker.com/products/overview#/install_the_platform)

## Run

The containers allow you to mount a directory of build scripts into the container and specify which script to run.

- `BUILD_PACKAGE`: the package to build
- `BUILD_VERSION`: the version of the package to build
- `BUILD_ITERATION`: the build iteration

For Example, the following will [build python](https://github.com/singleplatform-eng/docker-fpm/blob/master/ubuntu/trusty/build_scripts/build_python) for Ubuntu 14.04 and put a package in the current directory called _python-2.7.14-1.deb_

    docker run -v "$(pwd)"/build_scripts:/opt/build_scripts -v $(pwd):/mnt/shared -e BUILD_SCRIPT=build_python -e BUILD_VERSION=2.7.14 -e BUILD_ITERATION=1 bionic-fpm

## Build

    ./build.sh ubuntu/trusty/Dockerfile

## Contribute
Reference existing Dockerfiles and build scripts to get an idea of how packaging works with docker-fpm. All new Dockerfiles/build_scripts should be included in the Travis CI configuration. Two things are needed for tests to work.

Add a space delimited list of TEST_VERSIONS to the build script ([example](https://github.com/colinhoglund/docker-fpm/blob/master/ubuntu/trusty/build_scripts/build_python#L3))

    # TEST_VERSIONS: 2.7.12 3.5.2

Update Travis CI build matrix using the build.sh script and commit the updated .travis.yml

    ./build.sh --travis
