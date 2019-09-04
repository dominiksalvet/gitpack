#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks whether it is possible to install GitPack locally from the
#   source. It also checks whether the installed GitPack is able to uninstall
#   itself.
#-------------------------------------------------------------------------------

# install GitPack from the current commit locally
gitpack_out="$(src/gitpack install github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo "$gitpack_out" | grep '^\[install\]' &&

# check whether installed locally
gitpack_out="$(gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
# check whether uninstallation works
gitpack_out="$(gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[uninstall\]'
