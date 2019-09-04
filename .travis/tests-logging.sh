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
rm -f "$HOME"/.local/share/gitpack.log &&
# clean cache
echo test1 && gitpack clean > /dev/null &&
# check logging
echo test2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test3 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test4 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test5 && test "$(wc -l < "$HOME"/.local/share/gitpack.log)" -eq 3 &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test6 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack list > /dev/null &&
# check logging
echo test7 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack.log)" -eq 6 &&
echo test8 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test9 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack.log)" -eq 6 &&
echo test10 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack.log)" -eq 4 &&
echo test11 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack.log)" -eq 4 &&
echo test12 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack.log)" -eq 4 &&
echo test13 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack.log)" -eq 4 &&
echo test14 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack.log)" -eq 4 &&
echo test14 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test15 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test16 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test17 && test "$(wc -l < "$HOME"/.local/share/gitpack.log)" -eq 36 &&

# update to the latest version
echo test18 && gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack list > /dev/null &&
# check logging
echo test19 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack.log)" -eq 11 &&
echo test20 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test21 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack.log)" -eq 11 &&
echo test22 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack.log)" -eq 8 &&
echo test23 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack.log)" -eq 8 &&
echo test24 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack.log)" -eq 8 &&
echo test25 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack.log)" -eq 8 &&
echo test26 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack.log)" -eq 8 &&
echo test27 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack.log)" -eq 2 &&
echo test28 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack.log)" -eq 2 &&
echo test29 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack.log)" -eq 2 &&
echo test30 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test31 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test32 && test "$(wc -l < "$HOME"/.local/share/gitpack.log)" -eq 71 &&

# downgrade back to 2.1.0
echo test33 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack list > /dev/null &&
# check logging
echo test34 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack.log)" -eq 16 &&
echo test35 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test36 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack.log)" -eq 16 &&
echo test37 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack.log)" -eq 12 &&
echo test38 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack.log)" -eq 12 &&
echo test39 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack.log)" -eq 12 &&
echo test40 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack.log)" -eq 12 &&
echo test41 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack.log)" -eq 12 &&
echo test42 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test43 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test44 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test45 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack.log)" -eq 2 &&
echo test46 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack.log)" -eq 2 &&
echo test47 && test "$(wc -l < "$HOME"/.local/share/gitpack.log)" -eq 106 &&

# uninstall vhdldep
echo test48 && gitpack uninstall github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack uninstall github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
# check logging
echo test49 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack.log)" -eq 19 &&
echo test50 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack.log)" -eq 1 &&
echo test51 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack.log)" -eq 19 &&
echo test52 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test53 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test54 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test55 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test56 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test57 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test58 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test59 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test60 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test61 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test62 && test "$(wc -l < "$HOME"/.local/share/gitpack.log)" -eq 129 &&

# clean cache again
echo test63 && gitpack clean > /dev/null &&
# check logging
echo test64 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack.log)" -eq 20 &&
echo test65 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack.log)" -eq 2 &&
echo test66 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack.log)" -eq 20 &&
echo test67 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test68 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test69 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test70 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test71 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack.log)" -eq 15 &&
echo test72 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test73 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test74 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test75 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test76 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack.log)" -eq 3 &&
echo test77 && test "$(wc -l < "$HOME"/.local/share/gitpack.log)" -eq 132
