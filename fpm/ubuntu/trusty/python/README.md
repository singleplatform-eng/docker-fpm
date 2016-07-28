### Requirements
- [colinhoglund/fpm:ubuntu-trusty](https://github.com/colinhoglund/dockerfiles/tree/master/fpm/ubuntu/trusty/)

### Build
From this directory, run:
```
docker build -t colinhoglund/fpm-python:<os>-<release> .
```

### Usage:
The following will create _python-local-VERSION-ITERATION.deb_ in the host machine's current directory:
```
docker run -v `pwd`:/mnt/shared colinhoglund/fpm-python:ubuntu-trusty
```

### Description
In order to not interfere with the system version of Python, I opted to call this build of Python _python-local_. This image runs [build_python.sh](https://github.com/colinhoglund/dockerfiles/blob/master/fpm/ubuntu/trusty/python/build_python.sh), which uses fpm to build and package _python-local_. Dependencies for _python-local_ are based on the packages used to build _python-local_ and the existing Debian Python dependency tree.

```
Debian Python Dependency Tree

python
|_python2.7
| |_python2.7-minimal
| | |_libpython2.7-minimal
| | |_zlib1g
| |
| |_libpython2.7-stdlib
| |_mime-support
|
|_python-minimal
|_libpython-stdlib
  |_libpython2.7-stdlib
    |_libbz2-1.0
    |_libc6
    |_libdb5.3
    |_libexpat1
    |_libffi6
    |_libncursesw5
    |_libreadline6
    |_libsqlite3-0
    |_libssl1.0.0
    |_libtinfo5
```
