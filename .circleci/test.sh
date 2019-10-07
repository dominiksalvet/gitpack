#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Tests the basic functionality and behavior of GitPack. The current state of
#   execution is reported to stderr.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# USAGE
#-------------------------------------------------------------------------------
# Checks exit codes and output of basic user usage and related circumstances.
#-------------------------------------------------------------------------------

# check GitPack commands
echo command1 >&2 && src/gitpack list &&
echo command2 >&2 && src/gitpack clean &&
echo command3 >&2 && src/gitpack about &&
echo command4 >&2 && src/gitpack help &&

# install older version
echo install1 >&2 && gitpack_out="$(src/gitpack status github.com/dominiksalvet/gitpack=0.1.0)" &&
echo install2 >&2 && echo "$gitpack_out" | grep '^\[nothing\]' &&
echo install3 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo install4 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&
echo install5 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo install6 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo install7 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo install8 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo install9 >&2 && gitpack_out="$(src/gitpack list)" &&
echo install10 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/gitpack' &&
# check installed files
echo install11 >&2 && test -x /usr/local/bin/gitpack &&

# install current version + test status file recovery
echo update1 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack)" &&
echo update2 >&2 && echo "$gitpack_out" | grep '^\[older\]' &&
echo update3 >&2 && rm ~/.local/share/gitpack/status &&
echo update4 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack)" &&
echo update5 >&2 && echo "$gitpack_out" | grep '^\[update\]' &&
echo update6 >&2 && rm ~/.local/share/gitpack/status &&
echo update7 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack)" &&
echo update8 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo update9 >&2 && rm ~/.local/share/gitpack/status &&
echo update10 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack)" &&
echo update11 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo update12 >&2 && rm ~/.local/share/gitpack/status &&
echo update13 >&2 && gitpack_out="$(src/gitpack list)" &&
echo update14 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/gitpack' &&
echo update15 >&2 && rm ~/.local/share/gitpack/status &&
# check installed files
echo update16 >&2 && test -x ~/.local/bin/gitpack &&
echo update17 >&2 && test -f ~/.bash_completion.d/gitpack-completion.bash &&
echo update18 >&2 && test ! -x ~/.bash_completion.d/gitpack-completion.bash &&

# downgrade to older version
echo downgrade1 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo downgrade2 >&2 && echo "$gitpack_out" | grep '^\[newer\]' &&
echo downgrade3 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo downgrade4 >&2 && echo "$gitpack_out" | grep '^\[downgrade\]' &&
echo downgrade5 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo downgrade6 >&2 && echo "$gitpack_out" | grep '^\[installed\]' &&
echo downgrade7 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo downgrade8 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo downgrade9 >&2 && gitpack_out="$(src/gitpack list)" &&
echo downgrade10 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/gitpack' &&
# check installed files
echo downgrade11 >&2 && test -x ~/.local/bin/gitpack &&
echo downgrade12 >&2 && test ! -e ~/.bash_completion.d/gitpack-completion.bash &&

# uninstall
echo uninstall1 >&2 && gitpack_out="$(src/gitpack uninstall -o github.com/dominiksalvet/gitpack)" &&
echo uninstall2 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]' &&
echo uninstall3 >&2 && gitpack_out="$(src/gitpack uninstall -o github.com/dominiksalvet/gitpack)" &&
echo uninstall4 >&2 && echo "$gitpack_out" | grep '^\[uninstalled\]' &&
echo uninstall5 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack)" &&
echo uninstall6 >&2 && echo "$gitpack_out" | grep '^\[nothing\]' &&
# check installed files
echo uninstall7 >&2 && test ! -e ~/.local/bin/gitpack &&
echo uninstall8 >&2 && test ! -e ~/.bash_completion.d/gitpack-completion.bash &&

# expected to fail
echo xfail1 >&2 && ! src/gitpack 2>/dev/null && # no argument
echo xfail2 >&2 && ! src/gitpack duck 2>/dev/null && # invalid argument
echo xfail3 >&2 && ! src/gitpack -o 2>/dev/null && # invalid argument
echo xfail4 >&2 && ! src/gitpack status 2>/dev/null && # no URL
echo xfail5 >&2 && ! src/gitpack status -o 2>/dev/null && # no URL
echo xfail6 >&2 && ! src/gitpack status -w github.com/dominiksalvet/gitpack 2>/dev/null && # invalid option
# unsupported URL
echo xfail7 >&2 && ! gitpack_out="$(src/gitpack status github.com 2>&1)" &&
echo xfail8 >&2 && echo "$gitpack_out" | grep '^<ERROR>' &&
echo xfail9 >&2 && ! gitpack_out="$(src/gitpack status github.com/a 2>&1)" &&
echo xfail10 >&2 && echo "$gitpack_out" | grep '^<ERROR>' &&
echo xfail11 >&2 && ! gitpack_out="$(src/gitpack status github.com/a/b/c 2>&1)" &&
echo xfail12 >&2 && echo "$gitpack_out" | grep '^<ERROR>' &&

#-------------------------------------------------------------------------------
# FILES
#-------------------------------------------------------------------------------
# This test checks the correct existence and contents of GitPack files.
#-------------------------------------------------------------------------------

# existence of log files
echo logfiles1 >&2 && test -d ~/.local/share/gitpack/ &&
echo logfiles2 >&2 && test -r ~/.local/share/gitpack/ &&
echo logfiles3 >&2 && test -w ~/.local/share/gitpack/ &&
echo logfiles4 >&2 && test -x ~/.local/share/gitpack/ &&
echo logfiles5 >&2 && test -f ~/.local/share/gitpack/gitpack.log &&
echo logfiles6 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo logfiles7 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo logfiles8 >&2 && test ! -x ~/.local/share/gitpack/gitpack.log &&

# existence of cache files
echo cachefiles1 >&2 && test -d ~/.cache/gitpack/ &&
echo cachefiles2 >&2 && test -r ~/.cache/gitpack/ &&
echo cachefiles3 >&2 && test -w ~/.cache/gitpack/ &&
echo cachefiles4 >&2 && test -x ~/.cache/gitpack/ &&
echo cachefiles5 >&2 && test -d ~/.cache/gitpack/repo/ &&
echo cachefiles6 >&2 && test -r ~/.cache/gitpack/repo/ &&
echo cachefiles7 >&2 && test -w ~/.cache/gitpack/repo/ &&
echo cachefiles8 >&2 && test -x ~/.cache/gitpack/repo/ &&
echo cachefiles9 >&2 && test -d ~/.cache/gitpack/repo/github.com/ &&
echo cachefiles10 >&2 && test -r ~/.cache/gitpack/repo/github.com/ &&
echo cachefiles11 >&2 && test -w ~/.cache/gitpack/repo/github.com/ &&
echo cachefiles12 >&2 && test -x ~/.cache/gitpack/repo/github.com/ &&
echo cachefiles13 >&2 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo cachefiles14 >&2 && test -r ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo cachefiles15 >&2 && test -w ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo cachefiles16 >&2 && test -x ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo cachefiles17 >&2 && test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo cachefiles18 >&2 && test -r ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo cachefiles19 >&2 && test -w ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo cachefiles20 >&2 && test -x ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo cachefiles21 >&2 && test ! -d ~/.cache/gitpack/repo/github.com/a/ &&

# existence of state files
echo statefiles1 >&2 && test -r ~/.local/share/gitpack/status &&
echo statefiles2 >&2 && test -w ~/.local/share/gitpack/status &&
echo statefiles3 >&2 && test ! -x ~/.local/share/gitpack/status &&
echo statefiles4 >&2 && test -r ~/.local/share/gitpack/status.bak &&
echo statefiles5 >&2 && test -w ~/.local/share/gitpack/status.bak &&
echo statefiles6 >&2 && test ! -x ~/.local/share/gitpack/status.bak &&

# contents of status file
echo status1 >&2 && test ! "$(cat ~/.local/share/gitpack/status)" &&

# contents of log file
echo log1 >&2 && test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 26 &&
echo log2 >&2 && test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 26 &&
echo log3 >&2 && test "$(grep -Fc '[backup]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo log4 >&2 && test "$(grep -Fc '[fail]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo log5 >&2 && test "$(grep -Fc '[signal]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log6 >&2 && test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 26 &&
echo log7 >&2 && test "$(grep -Fc '[list]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo log8 >&2 && test "$(grep -Fc '[clean]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo log9 >&2 && test "$(grep -Fc '[action]' ~/.local/share/gitpack/gitpack.log)" -eq 18 &&
echo log10 >&2 && test "$(grep -Fc '[url]' ~/.local/share/gitpack/gitpack.log)" -eq 18 &&
echo log11 >&2 && test "$(grep -Fc '[refresh]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo log12 >&2 && test "$(grep -Fc '[execute]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo log13 >&2 && test "$(grep -Fc '[deps]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log14 >&2 && test "$(grep -Fc '[get]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo log15 >&2 && test "$(grep -Fc '[insert]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo log16 >&2 && test "$(grep -Fc '[delete]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo log17 >&2 && test "$(grep -Fc '[precp]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo log18 >&2 && test "$(grep -Fc '[cp]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo log19 >&2 && test "$(grep -Fc '[postcp]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log20 >&2 && test "$(grep -Fc '[prerm]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log21 >&2 && test "$(grep -Fc '[rm]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo log22 >&2 && test "$(grep -Fc '[postrm]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log23 >&2 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 203 &&

# clean files
echo clean1 >&2 && src/gitpack clean &&

# existence of log files
echo clean2 >&2 && test -d ~/.local/share/gitpack/ &&
echo clean3 >&2 && test -r ~/.local/share/gitpack/ &&
echo clean4 >&2 && test -w ~/.local/share/gitpack/ &&
echo clean5 >&2 && test -x ~/.local/share/gitpack/ &&
echo clean6 >&2 && test -f ~/.local/share/gitpack/gitpack.log &&
echo clean7 >&2 && test -r ~/.local/share/gitpack/gitpack.log &&
echo clean8 >&2 && test -w ~/.local/share/gitpack/gitpack.log &&
echo clean9 >&2 && test ! -x ~/.local/share/gitpack/gitpack.log &&

# existence of cache files
echo clean10 >&2 && test ! -d ~/.cache/gitpack/
