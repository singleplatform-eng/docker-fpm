### Requirements
- [fpm/ubuntu](https://github.com/colinhoglund/dockerfiles/tree/master/fpm/ubuntu)

### Build
From this directory, run:
```
docker build -t fpm/ubuntu/python .
```

### Usage:
The following will create _/Users/USERNAME/Downloads/python-local-VERSION-ITERATION.deb_ on the host machine:
```
docker run -v /Users/USERNAME/Downloads:/mnt/shared fpm/ubuntu/python
```

### Description
In order to not interfere with the system version of Python, I opted to call this build of Python _python-local_. To build the _python-local_ package, this image runs something simliar to [build_python.sh](https://github.com/colinhoglund/dockerfiles/blob/master/fpm/ubuntu/python/build_python.sh), which uses fpm to build and package _python-local_. Dependencies for _python-local_ are based on the packages used to build _python-local_ and the existing Debian Python dependency tree.

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
