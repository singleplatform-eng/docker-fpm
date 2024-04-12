#FROM ubuntu:jammy
FROM public.ecr.aws/ubuntu/ubuntu:jammy
RUN apt-get update -y && apt-get install -y locales
# setup environment
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

ENV FPM_BUILD_SCRIPTS /opt/build_scripts
ENV BUILD_OUTPUT_DIR /mnt/shared
ENV PATH "$PATH:$FPM_BUILD_SCRIPTS"

# install fpm
RUN /usr/sbin/locale-gen en_US.UTF-8 && apt-get install -y build-essential ruby-dev lsb-release && gem install fpm

# define shared volume
VOLUME $BUILD_OUTPUT_DIR

# add build scripts
ADD build_scripts $FPM_BUILD_SCRIPTS

# development option to mount local build scripts to test builds
VOLUME $FPM_BUILD_SCRIPTS
