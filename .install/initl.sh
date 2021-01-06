#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

echo 'installing GitPack locally' &&

# prepare a temporary directory for the user
user_id="$(id -u)" &&
mkdir -p /tmp/first-gitpack/ &&
mkdir "/tmp/first-gitpack/$user_id/" && # mutual exclusion (until reboot)
cd "/tmp/first-gitpack/$user_id/" &&

# clone and prepare the repository
git clone -q https://github.com/dominiksalvet/gitpack.git . &&
latest_version="$(git describe --tags --abbrev=0)" &&
git checkout -q "$latest_version" &&

# install GitPack using GitPack
src/gitpack install github.com/dominiksalvet/gitpack &&

echo 'success'
