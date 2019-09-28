#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks whether GitPack works correctly during a basic usage.
#-------------------------------------------------------------------------------

# basic functions
echo usage1 && gitpack about &&
echo usage2 && gitpack help &&
echo usage3 && gitpack clean && # clean cache

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo usage4 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage5 && echo "$gitpack_out" | grep '^\[nothing\]' &&
echo usage6 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage7 && echo "$gitpack_out" | grep '^\[install\]' &&
echo usage8 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage9 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo usage10 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage11 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo usage12 && gitpack_out="$(gitpack list)" &&
echo usage13 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# update to the latest version
echo usage14 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo usage15 && echo "$gitpack_out" | grep '^\[older\]' &&
echo usage16 && rm ~/.local/share/gitpack/status && # should be recovered from a backup
echo usage17 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo usage18 && echo "$gitpack_out" | grep '^\[update\]' &&
echo usage19 && rm ~/.local/share/gitpack/status &&
echo usage20 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo usage21 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo usage22 && rm ~/.local/share/gitpack/status &&
echo usage23 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo usage24 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo usage25 && rm ~/.local/share/gitpack/status &&
echo usage26 && gitpack_out="$(gitpack list)" &&
echo usage27 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&
echo usage28 && rm ~/.local/share/gitpack/status &&

# downgrade back to 2.1.0
echo usage29 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage30 && echo "$gitpack_out" | grep '^\[newer\]' &&
echo usage31 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage32 && echo "$gitpack_out" | grep '^\[downgrade\]' &&
echo usage33 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage34 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo usage35 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage36 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo usage37 && gitpack_out="$(gitpack list)" &&
echo usage38 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# uninstall vhdldep
echo usage39 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo usage40 && echo "$gitpack_out" | grep '^\[uninstall\]' &&
echo usage41 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo usage42 && echo "$gitpack_out" | grep '^\[uninstalled\]' &&
echo usage43 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo usage44 && echo "$gitpack_out" | grep '^\[nothing\]' &&

# intentionally bad URL
echo usage45 && ! gitpack_out="$(gitpack status github.com/a/b/c 2>&1)" &&
echo usage46 && echo "$gitpack_out" | grep '^<ERROR>' &&

# clean cache again
echo usage47 && gitpack clean
