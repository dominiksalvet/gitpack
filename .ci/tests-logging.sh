#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks correct GitPack execution logging to a log file.
#-------------------------------------------------------------------------------

# remove log of the initial installation
rm -f "$HOME"/.local/share/gitpack/gitpack.log &&
# clean cache
echo test1 >&2 && gitpack clean &&
# check logging
echo test2 >&2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test3 >&2 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test4 >&2 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test5 >&2 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test6 >&2 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test7 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check logging
echo test8 >&2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo test9 >&2 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test10 >&2 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo test11 >&2 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo test12 >&2 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test13 >&2 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test14 >&2 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test15 >&2 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test16 >&2 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test17 >&2 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test18 >&2 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test19 >&2 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test20 >&2 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 42 &&

# update to the latest version
echo test21 >&2 && gitpack status github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
gitpack list &&
# check logging
echo test22 >&2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo test23 >&2 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test24 >&2 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo test25 >&2 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo test26 >&2 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test27 >&2 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test28 >&2 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test29 >&2 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test30 >&2 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test31 >&2 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test32 >&2 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test33 >&2 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test34 >&2 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test35 >&2 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test36 >&2 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 82 &&

# downgrade back to 2.1.0
echo test37 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check logging
echo test38 >&2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo test39 >&2 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test40 >&2 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo test41 >&2 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo test42 >&2 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test43 >&2 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test44 >&2 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test45 >&2 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test46 >&2 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test47 >&2 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test48 >&2 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test49 >&2 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test50 >&2 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test51 >&2 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test52 >&2 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 122 &&

# uninstall vhdldep
echo test53 >&2 && gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
# check logging
echo test54 >&2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo test55 >&2 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test56 >&2 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo test57 >&2 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo test58 >&2 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test59 >&2 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test60 >&2 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test61 >&2 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test62 >&2 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test63 >&2 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test64 >&2 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test65 >&2 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test66 >&2 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test67 >&2 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test68 >&2 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 148 &&

# intentionally bad URL
echo test69 >&2 && ! gitpack status github.com &&
# check logging
echo test70 >&2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo test71 >&2 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test72 >&2 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo test73 >&2 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo test74 >&2 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo test75 >&2 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo test76 >&2 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test77 >&2 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test78 >&2 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test79 >&2 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test80 >&2 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test81 >&2 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test82 >&2 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test83 >&2 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test84 >&2 && test "$(grep -c '\[fail\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test85 >&2 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 153 &&

# clean cache again
echo test86 >&2 && gitpack clean &&
# check logging
echo test87 >&2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 21 &&
echo test88 >&2 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test89 >&2 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo test90 >&2 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 21 &&
echo test91 >&2 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test92 >&2 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test93 >&2 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test94 >&2 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test95 >&2 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test96 >&2 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test97 >&2 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test98 >&2 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test99 >&2 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test100 >&2 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test101 >&2 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 157
