[![Build Status](https://travis-ci.org/colinhoglund/docker-fpm.svg?branch=master)](https://travis-ci.org/colinhoglund/docker-fpm)

# docker-fpm
Use [fpm](https://github.com/jordansissel/fpm) inside [Docker](https://www.docker.com/) containers to easily build various OS packages.

Pre-built images can be pulled from [hub.docker.com](https://hub.docker.com/r/colinhoglund/fpm/).

## Requirements
- [Docker](https://www.docker.com/products/overview#/install_the_platform)

## Run
Pull an image for your preferred OS

    docker pull colinhoglund/fpm:ubuntu-trusty

By default, running these containers executes a specified build script based on the following environment variables.

- `BUILD_PACKAGE`: the package to build
- `BUILD_VERSION`: the version of the package to build
- `BUILD_ITERATION`: the build iteration

For Example, the following will [build python](https://github.com/colinhoglund/docker-fpm/blob/master/ubuntu/trusty/build_scripts/build_python) for Ubuntu 14.04 and put a package in the current directory called _python-local-3.5.2-1.deb_

    docker run -e 'BUILD_PACKAGE=python' -e 'BUILD_VERSION=3.5.2' -e 'BUILD_ITERATION=1' -v `pwd`:/mnt/shared colinhoglund/fpm:ubuntu-trusty

## Build

    ./build.sh ubuntu/trusty/Dockerfile
