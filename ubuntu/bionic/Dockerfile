FROM ubuntu:bionic

RUN apt-get update -y && apt-get install locales
# setup environment
RUN /usr/sbin/locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

ENV FPM_BUILD_SCRIPTS /opt/build_scripts
ENV BUILD_OUTPUT_DIR /mnt/shared

# install fpm
RUN apt-get update \
 && apt-get install -y build-essential ruby-dev lsb-release\
 && gem install fpm

# define shared volume
VOLUME $BUILD_OUTPUT_DIR

# add build scripts
ADD build_scripts $FPM_BUILD_SCRIPTS
VOLUME $FPM_BUILD_SCRIPTS

# execute build script for specified package
CMD ${FPM_BUILD_SCRIPTS}/${BUILD_SCRIPT}
