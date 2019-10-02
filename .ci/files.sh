#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks the correct existence files that GitPack works with. The
#   current state of execution is reported to stderr.
#-------------------------------------------------------------------------------

# basic functions
echo files1 >&2 && gitpack about &&
gitpack help &&
gitpack clean && # clean cache
# check files
echo files2 >&2 && test -d ~/.local/share/gitpack/ &&
echo files3 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files4 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files5 >&2 && test -r ~/.local/share/gitpack/status &&
echo files6 >&2 && test -w ~/.local/share/gitpack/status &&
echo files7 >&2 && test -r ~/.local/share/gitpack/status.bak &&
echo files8 >&2 && test -w ~/.local/share/gitpack/status.bak &&
echo files9 >&2 && test ! -d ~/.cache/gitpack/ &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo files10 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check files
echo files11 >&2 && test -d ~/.local/share/gitpack/ &&
echo files12 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files13 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files14 >&2 && test -r ~/.local/share/gitpack/status &&
echo files15 >&2 && test -w ~/.local/share/gitpack/status &&
echo files16 >&2 && test -r ~/.local/share/gitpack/status.bak &&
echo files17 >&2 && test -w ~/.local/share/gitpack/status.bak &&
echo files18 >&2 && test -d ~/.cache/gitpack/ &&
echo files19 >&2 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
# check vhdldep files
echo files20 >&2 && test -e ~/.local/bin/vhdldep &&

# update to the latest version
echo files21 >&2 && gitpack status github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack install github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
gitpack list &&
# check files
echo files22 >&2 && test -d ~/.local/share/gitpack/ &&
echo files23 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files24 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files25 >&2 && test -r ~/.local/share/gitpack/status &&
echo files26 >&2 && test -w ~/.local/share/gitpack/status &&
echo files27 >&2 && test -r ~/.local/share/gitpack/status.bak &&
echo files28 >&2 && test -w ~/.local/share/gitpack/status.bak &&
echo files29 >&2 && test -d ~/.cache/gitpack/ &&
echo files30 >&2 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
# check vhdldep files
echo files31 >&2 && test -e ~/.local/bin/vhdldep &&

# downgrade back to 2.1.0
echo files32 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check files
echo files33 >&2 && test -d ~/.local/share/gitpack/ &&
echo files34 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files35 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files36 >&2 && test -r ~/.local/share/gitpack/status &&
echo files37 >&2 && test -w ~/.local/share/gitpack/status &&
echo files38 >&2 && test -r ~/.local/share/gitpack/status.bak &&
echo files39 >&2 && test -w ~/.local/share/gitpack/status.bak &&
echo files40 >&2 && test -d ~/.cache/gitpack/ &&
echo files41 >&2 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
# check vhdldep files
echo files42 >&2 && test -e ~/.local/bin/vhdldep &&

# uninstall vhdldep
echo files43 >&2 && gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack uninstall github.com/dominiksalvet/vhdldep &&
gitpack status github.com/dominiksalvet/vhdldep &&
# check files
echo files44 >&2 && test -d ~/.local/share/gitpack/ &&
echo files45 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files46 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files47 >&2 && test -r ~/.local/share/gitpack/status &&
echo files48 >&2 && test -w ~/.local/share/gitpack/status &&
echo files49 >&2 && test -r ~/.local/share/gitpack/status.bak &&
echo files50 >&2 && test -w ~/.local/share/gitpack/status.bak &&
echo files51 >&2 && test -d ~/.cache/gitpack/ &&
echo files52 >&2 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
# check vhdldep files
echo files53 >&2 && test ! -e ~/.local/bin/vhdldep &&

# intentionally bad URL
echo files54 >&2 && ! gitpack status github.com/a/b/c 2>&1 &&
# check files
echo files55 >&2 && test -d ~/.local/share/gitpack/ &&
echo files56 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files57 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files58 >&2 && test -r ~/.local/share/gitpack/status &&
echo files59 >&2 && test -w ~/.local/share/gitpack/status &&
echo files60 >&2 && test -r ~/.local/share/gitpack/status.bak &&
echo files61 >&2 && test -w ~/.local/share/gitpack/status.bak &&
echo files62 >&2 && test -d ~/.cache/gitpack/ &&
echo files63 >&2 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/vhdldep/ &&
echo files64 >&2 && test ! -d ~/.cache/gitpack/repo/a/ &&

# clean cache again
echo files65 >&2 && rm ~/.local/share/gitpack/status && # should be recovered from a backup
echo files66 >&2 && gitpack clean &&
# check files
echo files67 >&2 && test -d ~/.local/share/gitpack/ &&
echo files68 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo files69 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo files70 >&2 && test -r ~/.local/share/gitpack/status &&
echo files71 >&2 && test -w ~/.local/share/gitpack/status &&
echo files72 >&2 && test -r ~/.local/share/gitpack/status.bak &&
echo files73 >&2 && test -w ~/.local/share/gitpack/status.bak &&
echo files74 >&2 && test ! -d ~/.cache/gitpack/
