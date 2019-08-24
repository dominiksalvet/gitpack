#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# install GitPack from the current commit globally
gitpack_out="$(sudo src/gitpack install github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo "$gitpack_out" | grep '^\[install\]' &&

# check whether installed globally
gitpack_out="$(sudo gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
# must not be installed locally
gitpack_out="$(gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo "$gitpack_out" | grep '^\[nothing\]' &&
# check whether uninstallation works
gitpack_out="$(sudo gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[uninstall\]'
