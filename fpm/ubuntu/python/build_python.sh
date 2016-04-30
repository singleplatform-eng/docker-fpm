#!/bin/bash

OUTPUT_DIR=`pwd`
PYTHON_VERSION=2.7.10
BUILD_ITERATION=1

apt-get update

# Build dependencies
apt-get install -y ruby-dev wget
gem install fpm

# Python dependencies
apt-get install -y \
  build-essential \
  libbz2-dev \
  libdb-dev \
  libgdbm-dev \
  liblzma-dev \
  libncursesw5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  python-dev \
  tk-dev \
  zlib1g-dev

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
  --package ${OUTPUT_DIR}/python-local-VERSION-ITERATION.deb \
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
