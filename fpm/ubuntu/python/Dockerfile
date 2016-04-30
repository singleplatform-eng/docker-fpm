FROM fpm/ubuntu

# Define shared volume
VOLUME /mnt/shared

# Setup environment
ENV PYTHON_VERSION 2.7.10
ENV BUILD_ITERATION 1

# Install dependencies
RUN apt-get update; \
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
      zlib1g-dev \
      wget

# Build Python package
RUN cd /opt; \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz; \
    tar xfv Python-${PYTHON_VERSION}.tgz; \
    cd Python-${PYTHON_VERSION}; \
    ./configure --prefix=/usr/local; make; \
    mkdir /opt/python_build; \
    make install DESTDIR=/opt/python_build; \
    fpm -s dir -t deb \
      -C /opt/python_build/ \
      --name python-local \
      --version ${PYTHON_VERSION} \
      --iteration ${BUILD_ITERATION} \
      --package /opt/python-local-VERSION-ITERATION.deb \
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

CMD /bin/cp /opt/python-local-${PYTHON_VERSION}-${BUILD_ITERATION}.deb /mnt/shared/
