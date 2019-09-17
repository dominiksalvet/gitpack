#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks the correct existence of GitPack files.
#-------------------------------------------------------------------------------

# clean cache
echo test1 >&2 && gitpack clean &&
# check files
echo test3 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo test4 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo test5 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo test6 >&2 && test -r "$HOME"/.local/share/gitpack/status &&
echo test7 >&2 && test -w "$HOME"/.local/share/gitpack/status &&
echo test8 >&2 && test -r "$HOME"/.local/share/gitpack/status.bak &&
echo test9 >&2 && test -w "$HOME"/.local/share/gitpack/status.bak &&
echo test10 >&2 && test ! -d "$HOME"/.cache/gitpack/ &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo test11 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check files
echo test12 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo test13 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo test14 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo test15 >&2 && test -r "$HOME"/.local/share/gitpack/status &&
echo test16 >&2 && test -w "$HOME"/.local/share/gitpack/status &&
echo test17 >&2 && test -r "$HOME"/.local/share/gitpack/status.bak &&
echo test18 >&2 && test -w "$HOME"/.local/share/gitpack/status.bak &&
echo test19 >&2 && test -d "$HOME"/.cache/gitpack/ &&
echo test20 >&2 && test -d "$HOME"/.cache/gitpack/repo/ &&
echo test21 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo test22 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&

# update to the latest version
echo test23 >&2 && gitpack status github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
gitpack list &&
# check files
echo test24 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo test25 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo test26 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo test27 >&2 && test -r "$HOME"/.local/share/gitpack/status &&
echo test28 >&2 && test -w "$HOME"/.local/share/gitpack/status &&
echo test29 >&2 && test -r "$HOME"/.local/share/gitpack/status.bak &&
echo test30 >&2 && test -w "$HOME"/.local/share/gitpack/status.bak &&
echo test31 >&2 && test -d "$HOME"/.cache/gitpack/ &&
echo test32 >&2 && test -d "$HOME"/.cache/gitpack/repo/ &&
echo test33 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo test34 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&

# downgrade back to 2.1.0
echo test35 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check files
echo test36 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo test37 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo test38 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo test39 >&2 && test -r "$HOME"/.local/share/gitpack/status &&
echo test40 >&2 && test -w "$HOME"/.local/share/gitpack/status &&
echo test41 >&2 && test -r "$HOME"/.local/share/gitpack/status.bak &&
echo test42 >&2 && test -w "$HOME"/.local/share/gitpack/status.bak &&
echo test43 >&2 && test -d "$HOME"/.cache/gitpack/ &&
echo test44 >&2 && test -d "$HOME"/.cache/gitpack/repo/ &&
echo test45 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo test46 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&

# uninstall vhdldep
echo test47 >&2 && gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
# check files
echo test48 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo test49 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo test50 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo test51 >&2 && test -r "$HOME"/.local/share/gitpack/status &&
echo test52 >&2 && test -w "$HOME"/.local/share/gitpack/status &&
echo test53 >&2 && test -r "$HOME"/.local/share/gitpack/status.bak &&
echo test54 >&2 && test -w "$HOME"/.local/share/gitpack/status.bak &&
echo test55 >&2 && test -d "$HOME"/.cache/gitpack/ &&
echo test56 >&2 && test -d "$HOME"/.cache/gitpack/repo/ &&
echo test57 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo test58 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&

# intentionally bad URL
echo test59 >&2 && ! gitpack status github.com/a/b/c 2>&1 &&
# check files
echo test60 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo test61 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo test62 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo test63 >&2 && test -r "$HOME"/.local/share/gitpack/status &&
echo test64 >&2 && test -w "$HOME"/.local/share/gitpack/status &&
echo test65 >&2 && test -r "$HOME"/.local/share/gitpack/status.bak &&
echo test66 >&2 && test -w "$HOME"/.local/share/gitpack/status.bak &&
echo test67 >&2 && test -d "$HOME"/.cache/gitpack/ &&
echo test68 >&2 && test -d "$HOME"/.cache/gitpack/repo/ &&
echo test69 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo test70 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
echo test71 >&2 && test ! -d "$HOME"/.cache/gitpack/repo/a/ &&

# clean cache again
echo test72 >&2 && rm "$HOME"/.local/share/gitpack/status && # should be recovered from a backup
echo test73 >&2 && gitpack clean &&
# check files
echo test74 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo test75 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo test76 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo test77 >&2 && test -r "$HOME"/.local/share/gitpack/status &&
echo test78 >&2 && test -w "$HOME"/.local/share/gitpack/status &&
echo test79 >&2 && test -r "$HOME"/.local/share/gitpack/status.bak &&
echo test80 >&2 && test -w "$HOME"/.local/share/gitpack/status.bak &&
echo test81 >&2 && test ! -d "$HOME"/.cache/gitpack/
