FROM ubuntu:trusty

# setup environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# install fpm
RUN apt-get update && apt-get install -y build-essential ruby-dev && gem install fpm
