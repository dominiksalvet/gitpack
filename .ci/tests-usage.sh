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
echo test1 >&2 && gitpack about && # print about information
echo test2 >&2 && gitpack help && # print help information
echo test3 >&2 && gitpack clean && # clean cache

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test4 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[nothing\]' &&
echo test5 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[install\]' &&
echo test6 >&2 && rm "$HOME"/.local/share/gitpack/status && # should be recovered from a backup
echo test7 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[installed\]' &&
echo test8 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
echo test9 >&2 && gitpack_out="$(gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# update to the latest version
echo test10 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[older\]' &&
echo test11 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[update\]' &&
echo test12 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[installed\]' &&
echo test13 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
echo test14 >&2 && gitpack_out="$(gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# downgrade back to 2.1.0
echo test15 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[newer\]' &&
echo test16 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[downgrade\]' &&
echo test17 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[installed\]' &&
echo test18 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
echo test19 >&2 && gitpack_out="$(gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# uninstall vhdldep
echo test20 >&2 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[uninstall\]' &&
echo test21 >&2 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[uninstalled\]' &&
echo test22 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo "$gitpack_out" | grep '^\[nothing\]' &&

# clean cache again
echo test23 >&2 && gitpack clean
