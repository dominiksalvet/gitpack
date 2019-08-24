#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# check whether installed globally, not locally, and uninstall it
gitpack_out="$(sudo gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
gitpack_out="$(gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo "$gitpack_out" | grep '^\[nothing\]' &&
gitpack_out="$(sudo gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[uninstall\]'