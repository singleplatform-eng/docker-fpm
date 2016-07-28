#!/bin/bash

# Build Python
cd /tmp
wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
tar xfv Python-${PYTHON_VERSION}.tgz
cd Python-${PYTHON_VERSION}
./configure --prefix=/usr/local; make
mkdir /tmp/python_build
make install DESTDIR=/tmp/python_build

# Create .deb package
fpm -s dir -t deb \
  -C /tmp/python_build/ \
  --name python-local \
  --version ${PYTHON_VERSION} \
  --iteration ${BUILD_ITERATION} \
  --package /mnt/shared/python-local-VERSION-ITERATION.deb \
  --description "Install Python ${PYTHON_VERSION} to /usr/local/" \
  --depends libbz2-1.0 \
  --depends libc6 \
  --depends libdb5.3 \
  --depends libexpat1 \
  --depends libffi6 \
  --depends libncursesw5 \
  --depends libreadline6 \
  --depends libsqlite3-0 \
  --depends libssl1.0.0 \
  --depends libtinfo5 \
  --depends mime-support \
  --depends zlib1g
