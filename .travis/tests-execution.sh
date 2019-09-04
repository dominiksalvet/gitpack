#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# clean cache
echo test1 && gitpack clean > /dev/null &&
ps &&
echo test2 && test "$(ps | wc -l)" -eq 5 &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test3 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
echo test4 && test "$(ps | wc -l)" -eq 5 &&
echo test5 && gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
echo test6 && test "$(ps | wc -l)" -eq 5 &&
echo test7 && gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
echo test8 && test "$(ps | wc -l)" -eq 5 &&
echo test9 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
echo test10 && test "$(ps | wc -l)" -eq 5 &&
echo test11 && gitpack list > /dev/null &&
echo test12 && test "$(ps | wc -l)" -eq 5 &&

# update to the latest version
echo test13 && gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
echo test14 && test "$(ps | wc -l)" -eq 5 &&
echo test15 && gitpack install github.com/dominiksalvet/vhdldep > /dev/null &&
echo test16 && test "$(ps | wc -l)" -eq 5 &&
echo test17 && gitpack install github.com/dominiksalvet/vhdldep > /dev/null &&
echo test18 && test "$(ps | wc -l)" -eq 5 &&
echo test19 && gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
echo test20 && test "$(ps | wc -l)" -eq 5 &&
echo test21 && gitpack list > /dev/null &&
echo test22 && test "$(ps | wc -l)" -eq 5 &&

# downgrade back to 2.1.0
echo test23 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
echo test24 && test "$(ps | wc -l)" -eq 5 &&
echo test25 && gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
echo test26 && test "$(ps | wc -l)" -eq 5 &&
echo test27 && gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
echo test28 && test "$(ps | wc -l)" -eq 5 &&
echo test29 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
echo test30 && test "$(ps | wc -l)" -eq 5 &&
echo test31 && gitpack list > /dev/null &&
echo test32 && test "$(ps | wc -l)" -eq 5 &&

# uninstall vhdldep
echo test33 && gitpack uninstall github.com/dominiksalvet/vhdldep > /dev/null &&
echo test34 && test "$(ps | wc -l)" -eq 5 &&
echo test35 && gitpack uninstall github.com/dominiksalvet/vhdldep > /dev/null &&
echo test36 && test "$(ps | wc -l)" -eq 5 &&
echo test37 && gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
echo test38 && test "$(ps | wc -l)" -eq 5 &&

# clean cache again
echo test39 && gitpack clean > /dev/null &&
echo test40 && test "$(ps | wc -l)" -eq 5
