#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# check basic functions
echo test1 && gitpack about > /dev/null && # print about information
echo test2 && gitpack help > /dev/null && # print help information
echo test3 && gitpack clean > /dev/null && # clean cache

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test4 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test5 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[nothing\]' > /dev/null &&
echo test6 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test7 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[install\]' > /dev/null &&
echo test8 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test9 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[installed\]' > /dev/null &&
echo test10 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test11 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[ok\]' > /dev/null &&
echo test12 && gitpack_out="$(gitpack list)" &&
echo test13 && echo "$gitpack_out" && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' > /dev/null &&

# update to the latest version
echo test14 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo test15 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[older\]' > /dev/null &&
echo test16 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo test17 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[update\]' > /dev/null &&
echo test18 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo test19 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[installed\]' > /dev/null &&
echo test20 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo test21 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[ok\]' > /dev/null &&
echo test22 && gitpack_out="$(gitpack list)" &&
echo test23 && echo "$gitpack_out" && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' > /dev/null &&

# downgrade back to 2.1.0
echo test24 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test25 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[newer\]' > /dev/null &&
echo test26 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test27 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[downgrade\]' > /dev/null &&
echo test28 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test29 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[installed\]' > /dev/null &&
echo test30 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test31 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[ok\]' > /dev/null &&
echo test32 && gitpack_out="$(gitpack list)" &&
echo test33 && echo "$gitpack_out" && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' > /dev/null &&

# uninstall vhdldep
echo test34 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo test35 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[uninstall\]' > /dev/null &&
echo test36 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo test37 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[uninstalled\]' > /dev/null &&
echo test38 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo test39 && echo "$gitpack_out" && echo "$gitpack_out" | grep '^\[nothing\]' > /dev/null &&

# clean cache again
echo test40 && gitpack clean > /dev/null
