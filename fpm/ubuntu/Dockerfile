FROM ubuntu:trusty
MAINTAINER Colin Hoglund <colinhoglund@gmail.com>

# setup environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# install packages
RUN apt-get update
RUN apt-get install -y build-essential ruby-dev
RUN gem install fpm
