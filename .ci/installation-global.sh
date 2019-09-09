#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks whether it is possible to install GitPack globally from the
#   source. It also checks whether the installed GitPack is able to uninstall
#   itself.
#-------------------------------------------------------------------------------

# install GitPack from the current commit globally
echo test1 >&2 && gitpack_out="$(sudo src/gitpack install github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo test2 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&

# check whether installed globally
echo test3 >&2 && gitpack_out="$(sudo gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo test4 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
# must not be installed locally
echo test5 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo test6 >&2 && echo "$gitpack_out" | grep '^\[nothing\]' &&
# check whether uninstallation works
echo test7 >&2 && gitpack_out="$(sudo gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo test8 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]'
