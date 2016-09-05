#!/bin/bash

GIT_CHANGES='git diff --diff-filter=ACMR --name-only HEAD^'

# run test if TEST has been changed
if [ -n "$($GIT_CHANGES | grep $TEST)" ]; then
    # build image for TEST
    echo ./build.sh $(cut -d\/ -f1,2 <<< $TEST)/Dockerfile

    # build packages if TEST is a build script
    if [ -n "$(grep build_scripts <<< $TEST)" ]; then
        # get docker tag name from filepath
        tag=$(cut -d\/ -f1,2 <<< $TEST | sed 's/\//-/')
        # get package name from filename
        package=$(basename $TEST | sed 's/build_//')
        # get space delimited versions to test from file contents
        versions=$(grep TEST_VERSIONS $TEST | sed 's/.*TEST_VERSIONS:\s*//')

        # test all specified versions
        for version in $versions; do
            echo "docker run -e "BUILD_PACKAGE=${package}" -e "BUILD_VERSION=${version}" -e 'BUILD_ITERATION=1' -v `pwd`:/mnt/shared colinhoglund/fpm:${tag}"
        done
    fi
else
    echo "INFO: Skipping unchanged build for $TEST"
    exit 0
fi
