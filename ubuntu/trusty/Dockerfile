FROM ubuntu:trusty

# setup environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

ENV FPM_BUILD_SCRIPTS /opt/colinhoglund-fpm/build_scripts
ENV BUILD_OUTPUT_DIR /mnt/shared

# define shared volume
VOLUME $BUILD_OUTPUT_DIR

# add build scripts
ADD build_scripts $FPM_BUILD_SCRIPTS

# install fpm
RUN apt-get update \
 && apt-get install -y build-essential ruby-dev \
 && gem install fpm

# execute build script for specified package
CMD ${FPM_BUILD_SCRIPTS}/build_${BUILD_PACKAGE}
