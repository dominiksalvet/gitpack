#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks correct GitPack execution logging to a log file.
#-------------------------------------------------------------------------------

# remove the log to initialize this test
echo logging1 && rm -f ~/.local/share/gitpack/gitpack.log &&

# basic functions
echo logging2 && gitpack about &&
gitpack help &&
gitpack clean && # clean cache
# check logging
echo logging3 && test "$(grep -c '\[init\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging4 && test "$(grep -c '\[clean\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging5 && test "$(grep -c '\[backup\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging6 && test "$(grep -c '\[exit\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging7 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 4 &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo logging8 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check logging
echo logging9 && test "$(grep -c '\[init\]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo logging10 && test "$(grep -c '\[clean\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging11 && test "$(grep -c '\[backup\]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo logging12 && test "$(grep -c '\[exit\]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo logging13 && test "$(grep -c '\[action\]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging14 && test "$(grep -c '\[url\]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging15 && test "$(grep -c '\[refresh\]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging16 && test "$(grep -c '\[execute\]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging17 && test "$(grep -c '\[get\]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging18 && test "$(grep -c '\[cp\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging19 && test "$(grep -c '\[insert\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging20 && test "$(grep -c '\[list\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging21 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 42 &&

# update to the latest version
echo logging22 && gitpack status github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
gitpack list &&
# check logging
echo logging23 && test "$(grep -c '\[init\]' ~/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo logging24 && test "$(grep -c '\[clean\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging25 && test "$(grep -c '\[backup\]' ~/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo logging26 && test "$(grep -c '\[exit\]' ~/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo logging27 && test "$(grep -c '\[action\]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging28 && test "$(grep -c '\[url\]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging29 && test "$(grep -c '\[refresh\]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging30 && test "$(grep -c '\[execute\]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging31 && test "$(grep -c '\[get\]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging32 && test "$(grep -c '\[cp\]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging33 && test "$(grep -c '\[insert\]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging34 && test "$(grep -c '\[list\]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging35 && test "$(grep -c '\[rm\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging36 && test "$(grep -c '\[delete\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging37 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 82 &&

# downgrade back to 2.1.0
echo logging38 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check logging
echo logging39 && test "$(grep -c '\[init\]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging40 && test "$(grep -c '\[clean\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging41 && test "$(grep -c '\[backup\]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging42 && test "$(grep -c '\[exit\]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging43 && test "$(grep -c '\[action\]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging44 && test "$(grep -c '\[url\]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging45 && test "$(grep -c '\[refresh\]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging46 && test "$(grep -c '\[execute\]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging47 && test "$(grep -c '\[get\]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging48 && test "$(grep -c '\[cp\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging49 && test "$(grep -c '\[insert\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging50 && test "$(grep -c '\[list\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging51 && test "$(grep -c '\[rm\]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging52 && test "$(grep -c '\[delete\]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging53 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 122 &&

# uninstall vhdldep
echo logging54 && gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
# check logging
echo logging55 && test "$(grep -c '\[init\]' ~/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo logging56 && test "$(grep -c '\[clean\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging57 && test "$(grep -c '\[backup\]' ~/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo logging58 && test "$(grep -c '\[exit\]' ~/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo logging59 && test "$(grep -c '\[action\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging60 && test "$(grep -c '\[url\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging61 && test "$(grep -c '\[refresh\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging62 && test "$(grep -c '\[execute\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging63 && test "$(grep -c '\[get\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging64 && test "$(grep -c '\[cp\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging65 && test "$(grep -c '\[insert\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging66 && test "$(grep -c '\[list\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging67 && test "$(grep -c '\[rm\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging68 && test "$(grep -c '\[delete\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging69 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 148 &&

# intentionally bad URL
echo logging70 && ! gitpack status github.com/a/b/c 2>&1 &&
# check logging
echo logging71 && test "$(grep -c '\[init\]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo logging72 && test "$(grep -c '\[clean\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging73 && test "$(grep -c '\[backup\]' ~/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo logging74 && test "$(grep -c '\[exit\]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo logging75 && test "$(grep -c '\[action\]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging76 && test "$(grep -c '\[url\]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging77 && test "$(grep -c '\[refresh\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging78 && test "$(grep -c '\[execute\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging79 && test "$(grep -c '\[get\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging80 && test "$(grep -c '\[cp\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging81 && test "$(grep -c '\[insert\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging82 && test "$(grep -c '\[list\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging83 && test "$(grep -c '\[rm\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging84 && test "$(grep -c '\[delete\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging85 && test "$(grep -c '\[fail\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging86 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 153 &&

# clean cache again
echo logging87 && gitpack clean &&
# check logging
echo logging88 && test "$(grep -c '\[init\]' ~/.local/share/gitpack/gitpack.log)" -eq 21 &&
echo logging89 && test "$(grep -c '\[clean\]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging90 && test "$(grep -c '\[backup\]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo logging91 && test "$(grep -c '\[exit\]' ~/.local/share/gitpack/gitpack.log)" -eq 21 &&
echo logging92 && test "$(grep -c '\[action\]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging93 && test "$(grep -c '\[url\]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging94 && test "$(grep -c '\[refresh\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging95 && test "$(grep -c '\[execute\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging96 && test "$(grep -c '\[get\]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging97 && test "$(grep -c '\[cp\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging98 && test "$(grep -c '\[insert\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging99 && test "$(grep -c '\[list\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging100 && test "$(grep -c '\[rm\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging101 && test "$(grep -c '\[delete\]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging102 && test "$(grep -c '\[fail\]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging103 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 157
