FROM centos:7

ENV FPM_BUILD_SCRIPTS /opt/colinhoglund-fpm/build_scripts
ENV BUILD_OUTPUT_DIR /mnt/shared

# define shared volume
VOLUME $BUILD_OUTPUT_DIR

# add build scripts
ADD build_scripts $FPM_BUILD_SCRIPTS

# install fpm
RUN yum install -y ruby-devel gcc make \
 && gem install fpm

# execute build script for specified package
CMD ${FPM_BUILD_SCRIPTS}/build_${BUILD_PACKAGE}
