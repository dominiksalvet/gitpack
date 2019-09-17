#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks whether it is possible to install GitPack locally from the
#   source. It also checks whether the installed GitPack is able to uninstall
#   itself.
#-------------------------------------------------------------------------------

# install GitPack from the current commit locally
echo test1 >&2 && gitpack_out="$(src/gitpack install github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo test2 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&

# check whether installed locally
echo test3 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo test4 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
# check whether uninstallation works
echo test5 >&2 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo test6 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]'
