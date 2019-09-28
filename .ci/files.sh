#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks the correct existence files that GitPack works with.
#-------------------------------------------------------------------------------

# basic functions
echo files1 && gitpack about &&
gitpack help &&
gitpack clean && # clean cache
# check files
echo files3 && test -d ~/.local/share/gitpack/ &&
echo files4 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files5 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files6 && test -r ~/.local/share/gitpack/status &&
echo files7 && test -w ~/.local/share/gitpack/status &&
echo files8 && test -r ~/.local/share/gitpack/status.bak &&
echo files9 && test -w ~/.local/share/gitpack/status.bak &&
echo files10 && test ! -d ~/.cache/gitpack/ &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo files11 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check files
echo files12 && test -d ~/.local/share/gitpack/ &&
echo files13 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files14 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files15 && test -r ~/.local/share/gitpack/status &&
echo files16 && test -w ~/.local/share/gitpack/status &&
echo files17 && test -r ~/.local/share/gitpack/status.bak &&
echo files18 && test -w ~/.local/share/gitpack/status.bak &&
echo files19 && test -d ~/.cache/gitpack/ &&
echo files20 && test -d ~/.cache/gitpack/repo/ &&
echo files21 && test -d ~/.cache/gitpack/repo/github.com/ &&
echo files22 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo files23 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
# check vhdldep files
echo files24 && test -e ~/.local/bin/vhdldep &&

# update to the latest version
echo files25 && gitpack status github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
gitpack list &&
# check files
echo files26 && test -d ~/.local/share/gitpack/ &&
echo files27 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files28 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files29 && test -r ~/.local/share/gitpack/status &&
echo files30 && test -w ~/.local/share/gitpack/status &&
echo files31 && test -r ~/.local/share/gitpack/status.bak &&
echo files32 && test -w ~/.local/share/gitpack/status.bak &&
echo files33 && test -d ~/.cache/gitpack/ &&
echo files34 && test -d ~/.cache/gitpack/repo/ &&
echo files35 && test -d ~/.cache/gitpack/repo/github.com/ &&
echo files36 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo files37 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
# check vhdldep files
echo files38 && test -e ~/.local/bin/vhdldep &&

# downgrade back to 2.1.0
echo files39 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check files
echo files40 && test -d ~/.local/share/gitpack/ &&
echo files41 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files42 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files43 && test -r ~/.local/share/gitpack/status &&
echo files44 && test -w ~/.local/share/gitpack/status &&
echo files45 && test -r ~/.local/share/gitpack/status.bak &&
echo files46 && test -w ~/.local/share/gitpack/status.bak &&
echo files47 && test -d ~/.cache/gitpack/ &&
echo files48 && test -d ~/.cache/gitpack/repo/ &&
echo files49 && test -d ~/.cache/gitpack/repo/github.com/ &&
echo files50 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo files51 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
# check vhdldep files
echo files52 && test -e ~/.local/bin/vhdldep &&

# uninstall vhdldep
echo files53 && gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
# check files
echo files54 && test -d ~/.local/share/gitpack/ &&
echo files55 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files56 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files57 && test -r ~/.local/share/gitpack/status &&
echo files58 && test -w ~/.local/share/gitpack/status &&
echo files59 && test -r ~/.local/share/gitpack/status.bak &&
echo files60 && test -w ~/.local/share/gitpack/status.bak &&
echo files61 && test -d ~/.cache/gitpack/ &&
echo files62 && test -d ~/.cache/gitpack/repo/ &&
echo files63 && test -d ~/.cache/gitpack/repo/github.com/ &&
echo files64 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo files65 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
# check vhdldep files
echo files66 && test ! -e ~/.local/bin/vhdldep &&

# intentionally bad URL
echo files67 && ! gitpack status github.com/a/b/c 2>&1 &&
# check files
echo files68 && test -d ~/.local/share/gitpack/ &&
echo files69 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files70 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files71 && test -r ~/.local/share/gitpack/status &&
echo files72 && test -w ~/.local/share/gitpack/status &&
echo files73 && test -r ~/.local/share/gitpack/status.bak &&
echo files74 && test -w ~/.local/share/gitpack/status.bak &&
echo files75 && test -d ~/.cache/gitpack/ &&
echo files76 && test -d ~/.cache/gitpack/repo/ &&
echo files77 && test -d ~/.cache/gitpack/repo/github.com/ &&
echo files78 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo files79 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
echo files80 && test ! -d ~/.cache/gitpack/repo/a/ &&

# clean cache again
echo files81 && rm ~/.local/share/gitpack/status && # should be recovered from a backup
echo files82 && gitpack clean &&
# check files
echo files83 && test -d ~/.local/share/gitpack/ &&
echo files84 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files85 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files86 && test -r ~/.local/share/gitpack/status &&
echo files87 && test -w ~/.local/share/gitpack/status &&
echo files88 && test -r ~/.local/share/gitpack/status.bak &&
echo files89 && test -w ~/.local/share/gitpack/status.bak &&
echo files90 && test ! -d ~/.cache/gitpack/
