[![Build Status](https://travis-ci.org/colinhoglund/docker-fpm.svg?branch=master)](https://travis-ci.org/colinhoglund/docker-fpm)

# docker-fpm
Dockerfiles for building packages with [fpm](https://github.com/jordansissel/fpm).

Pre-built images can be pulled from [hub.docker.com](https://hub.docker.com/r/colinhoglund/fpm/).

## Build

    docker build -t colinhoglund/fpm:<os-release> .

## Run
By default, running these containers executes a specified build script based on the following environment variables.

- `BUILD_PACKAGE`: the package being built
- `BUILD_VERSION`: the version of the package to build
- `BUILD_ITERATION`: the build iteration

For Example, the following will create a package in the current directory called _python-local-3.5.2-1.deb_

    docker run -e 'BUILD_PACKAGE=python' -e 'BUILD_VERSION=3.5.2' -e 'BUILD_ITERATION=1' -v `pwd`:/mnt/shared colinhoglund/fpm:ubuntu-trusty
