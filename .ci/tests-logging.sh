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
echo test1 && gitpack clean > /dev/null &&
# check logging
echo test2 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test3 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test4 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test5 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test6 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test7 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack list > /dev/null &&
# check logging
echo test8 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo test9 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test10 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo test11 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo test12 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test13 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test14 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test15 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test16 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo test17 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test18 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test19 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test20 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 42 &&

# update to the latest version
echo test21 && gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack list > /dev/null &&
# check logging
echo test22 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo test23 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test24 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo test25 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo test26 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test27 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test28 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test29 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test30 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo test31 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test32 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test33 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test34 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test35 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test36 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 82 &&

# downgrade back to 2.1.0
echo test37 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 > /dev/null &&
gitpack list > /dev/null &&
# check logging
echo test38 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo test39 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test40 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo test41 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo test42 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test43 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test44 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test45 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test46 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo test47 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test48 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test49 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test50 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test51 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test52 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 122 &&

# uninstall vhdldep
echo test53 && gitpack uninstall github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack uninstall github.com/dominiksalvet/vhdldep > /dev/null &&
gitpack status github.com/dominiksalvet/vhdldep > /dev/null &&
# check logging
echo test54 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo test55 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo test56 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo test57 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo test58 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test59 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test60 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test61 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test62 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test63 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test64 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test65 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test66 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test67 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test68 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 148 &&

# clean cache again
echo test69 && gitpack clean > /dev/null &&
# check logging
echo test70 && test "$(grep -c '\[init\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo test71 && test "$(grep -c '\[clean\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo test72 && test "$(grep -c '\[backup\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo test73 && test "$(grep -c '\[exit\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo test74 && test "$(grep -c '\[action\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test75 && test "$(grep -c '\[url\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test76 && test "$(grep -c '\[clone\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test77 && test "$(grep -c '\[execute\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test78 && test "$(grep -c '\[get\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo test79 && test "$(grep -c '\[cp\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test80 && test "$(grep -c '\[insert\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test81 && test "$(grep -c '\[list\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test82 && test "$(grep -c '\[rm\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test83 && test "$(grep -c '\[delete\]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo test84 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 152
