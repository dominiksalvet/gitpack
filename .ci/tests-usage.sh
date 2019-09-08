#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks whether GitPack works correctly during a basic usage.
#-------------------------------------------------------------------------------

# check basic functions
echo test1 && gitpack about > /dev/null && # print about information
echo test2 && gitpack help > /dev/null && # print help information
echo test3 && gitpack clean > /dev/null && # clean cache

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test4 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[nothing\]' > /dev/null &&
echo test5 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[install\]' > /dev/null &&
echo test6 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[installed\]' > /dev/null &&
echo test7 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[ok\]' > /dev/null &&
echo test8 && gitpack_out="$(gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' > /dev/null &&

# update to the latest version
echo test9 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[older\]' > /dev/null &&
echo test10 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[update\]' > /dev/null &&
echo test11 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[installed\]' > /dev/null &&
echo test12 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[ok\]' > /dev/null &&
echo test13 && gitpack_out="$(gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' > /dev/null &&

# downgrade back to 2.1.0
echo test14 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[newer\]' > /dev/null &&
echo test15 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[downgrade\]' > /dev/null &&
echo test16 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[installed\]' > /dev/null &&
echo test17 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[ok\]' > /dev/null &&
echo test18 && gitpack_out="$(gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' > /dev/null &&

# uninstall vhdldep
echo test19 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[uninstall\]' > /dev/null &&
echo test20 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[uninstalled\]' > /dev/null &&
echo test21 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[nothing\]' > /dev/null &&

# clean cache again
echo test22 && gitpack clean > /dev/null
