#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This script clones the GitPack repository for continuous integration tests
#   manually and prepares the appropriate environment variables. It is expected
#   to be sourced.
#-------------------------------------------------------------------------------

git clone https://github.com/dominiksalvet/gitpack.git dominiksalvet/gitpack/ &&
cd dominiksalvet/gitpack/ &&

if [ "$TRAVIS_PULL_REQUEST" != false ]; then
    git checkout -f "$TRAVIS_BRANCH" &&
    git merge "$TRAVIS_PULL_REQUEST_BRANCH" &&
    TRAVIS_COMMIT="$(git rev-parse --verify "$TRAVIS_BRANCH")"
fi &&

git checkout -f "$TRAVIS_COMMIT"
