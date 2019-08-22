#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------


gitpack_out="$(gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
gitpack_out="$(gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[uninstall\]'
