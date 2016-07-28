FROM colinhoglund/fpm:ubuntu-trusty

# Define shared volume
VOLUME /mnt/shared

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

# Add build script
ADD build_python.sh /usr/local/bin/build_python.sh

CMD build_python.sh
