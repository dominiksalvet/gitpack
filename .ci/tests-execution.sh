#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks GitPack execution characteristics.
#-------------------------------------------------------------------------------

# clean cache
echo test1 >&2 && gitpack clean &&
echo test2 >&2 && test "$(ps | wc -l)" -eq 6 && # check if there is no GitPack child process running

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test3 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
echo test4 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test6 >&2 && gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
echo test6 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test7 >&2 && gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
echo test8 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test9 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
echo test10 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test11 >&2 && gitpack list &&
echo test12 >&2 && test "$(ps | wc -l)" -eq 6 &&

# update to the latest version
echo test13 >&2 && gitpack status github.com/dominiksalvet/vhdldep &&
echo test14 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test16 >&2 && gitpack install github.com/dominiksalvet/vhdldep &&
echo test16 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test17 >&2 && gitpack install github.com/dominiksalvet/vhdldep &&
echo test18 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test19 >&2 && gitpack status github.com/dominiksalvet/vhdldep &&
echo test20 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test21 >&2 && gitpack list &&
echo test22 >&2 && test "$(ps | wc -l)" -eq 6 &&

# downgrade back to 2.1.0
echo test23 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
echo test24 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test26 >&2 && gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
echo test26 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test27 >&2 && gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
echo test28 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test29 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
echo test30 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test31 >&2 && gitpack list &&
echo test32 >&2 && test "$(ps | wc -l)" -eq 6 &&

# uninstall vhdldep
echo test33 >&2 && gitpack uninstall github.com/dominiksalvet/vhdldep &&
echo test34 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test36 >&2 && gitpack uninstall github.com/dominiksalvet/vhdldep &&
echo test36 >&2 && test "$(ps | wc -l)" -eq 6 &&
echo test37 >&2 && gitpack status github.com/dominiksalvet/vhdldep &&
echo test38 >&2 && test "$(ps | wc -l)" -eq 6 &&

# clean cache again
echo test39 >&2 && gitpack clean &&
echo test40 >&2 && test "$(ps | wc -l)" -eq 6
