#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
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
echo test5 >&2 && echo "$gitpack_out" | grep '^\[nothing\]' &&
echo test6 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test7 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&
echo test8 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test9 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo test10 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test11 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo test12 >&2 && gitpack_out="$(gitpack list)" &&
echo test13 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# update to the latest version
echo test14 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo test15 >&2 && echo "$gitpack_out" | grep '^\[older\]' &&
echo test16 >&2 && rm ~/.local/share/gitpack/status && # should be recovered from a backup
echo test17 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo test18 >&2 && echo "$gitpack_out" | grep '^\[update\]' &&
echo test19 >&2 && rm ~/.local/share/gitpack/status &&
echo test20 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo test21 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo test22 >&2 && rm ~/.local/share/gitpack/status &&
echo test23 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo test24 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo test25 >&2 && rm ~/.local/share/gitpack/status &&
echo test26 >&2 && gitpack_out="$(gitpack list)" &&
echo test27 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&
echo test28 >&2 && rm ~/.local/share/gitpack/status &&

# downgrade back to 2.1.0
echo test29 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test30 >&2 && echo "$gitpack_out" | grep '^\[newer\]' &&
echo test31 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test32 >&2 && echo "$gitpack_out" | grep '^\[downgrade\]' &&
echo test33 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test34 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo test35 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo test36 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo test37 >&2 && gitpack_out="$(gitpack list)" &&
echo test38 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# uninstall vhdldep
echo test39 >&2 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo test40 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]' &&
echo test41 >&2 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo test42 >&2 && echo "$gitpack_out" | grep '^\[uninstalled\]' &&
echo test43 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo test44 >&2 && echo "$gitpack_out" | grep '^\[nothing\]' &&

# intentionally bad URL
echo test45 >&2 && gitpack_out="$(! gitpack status github.com/a/b/c 2>&1)" &&
echo test46 >&2 && echo "$gitpack_out" | grep '^<ERROR>' &&

# clean cache again
echo test47 >&2 && gitpack clean
