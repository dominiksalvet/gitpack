#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks whether GitPack works correctly during a basic usage.
#-------------------------------------------------------------------------------

# basic functions
echo usage1 >&2 && gitpack about &&
echo usage2 >&2 && gitpack help &&
echo usage3 >&2 && gitpack clean && # clean cache

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo usage4 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage5 >&2 && echo "$gitpack_out" | grep '^\[nothing\]' &&
echo usage6 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage7 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&
echo usage8 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage9 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo usage10 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage11 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo usage12 >&2 && gitpack_out="$(gitpack list)" &&
echo usage13 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# update to the latest version
echo usage14 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo usage15 >&2 && echo "$gitpack_out" | grep '^\[older\]' &&
echo usage16 >&2 && rm ~/.local/share/gitpack/status && # should be recovered from a backup
echo usage17 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo usage18 >&2 && echo "$gitpack_out" | grep '^\[update\]' &&
echo usage19 >&2 && rm ~/.local/share/gitpack/status &&
echo usage20 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep)" &&
echo usage21 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo usage22 >&2 && rm ~/.local/share/gitpack/status &&
echo usage23 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo usage24 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo usage25 >&2 && rm ~/.local/share/gitpack/status &&
echo usage26 >&2 && gitpack_out="$(gitpack list)" &&
echo usage27 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&
echo usage28 >&2 && rm ~/.local/share/gitpack/status &&

# downgrade back to 2.1.0
echo usage29 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage30 >&2 && echo "$gitpack_out" | grep '^\[newer\]' &&
echo usage31 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage32 >&2 && echo "$gitpack_out" | grep '^\[downgrade\]' &&
echo usage33 >&2 && gitpack_out="$(gitpack install github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage34 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo usage35 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep=2.1.0)" &&
echo usage36 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo usage37 >&2 && gitpack_out="$(gitpack list)" &&
echo usage38 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/vhdldep' &&

# uninstall vhdldep
echo usage39 >&2 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo usage40 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]' &&
echo usage41 >&2 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/vhdldep)" &&
echo usage42 >&2 && echo "$gitpack_out" | grep '^\[uninstalled\]' &&
echo usage43 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/vhdldep)" &&
echo usage44 >&2 && echo "$gitpack_out" | grep '^\[nothing\]' &&

# intentionally bad URL
echo usage45 >&2 && ! gitpack_out="$(gitpack status github.com/a/b/c 2>&1)" &&
echo usage46 >&2 && echo "$gitpack_out" | grep '^<ERROR>' &&

# clean cache again
echo usage47 >&2 && gitpack clean
