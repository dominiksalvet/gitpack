#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This script tests basic functionality and behavior of GitPack. The current
#   state of execution is reported to stderr.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# INITIALIZATION
#-------------------------------------------------------------------------------

# prepare constants used in the tests below
echo inittests1 >&2 && SHORT_TRAVIS_COMMIT="$(echo "${TRAVIS_COMMIT:?}" | cut -c 1-7)" && true &&

#-------------------------------------------------------------------------------
# GLOBAL INSTALLATION
#-------------------------------------------------------------------------------
# Checks whether the current commit of GitPack can install itself globally.
#-------------------------------------------------------------------------------

# install, check status and uninstall it
echo global1 >&2 && gitpack_out="$(sudo src/gitpack install -h github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo global2 >&2 && test "$gitpack_out" = "[install] github.com/dominiksalvet/gitpack $SHORT_TRAVIS_COMMIT" &&
echo global3 >&2 && gitpack_out="$(sudo src/gitpack status -oh github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo global4 >&2 && test "$gitpack_out" = "[ok] github.com/dominiksalvet/gitpack $SHORT_TRAVIS_COMMIT" &&
echo global5 >&2 && gitpack_out="$(sudo src/gitpack uninstall -oh github.com/dominiksalvet/gitpack)" &&
echo global6 >&2 && test "$gitpack_out" = "[uninstall] github.com/dominiksalvet/gitpack $SHORT_TRAVIS_COMMIT" &&

# clean all global GitPack files
echo global7 >&2 && sudo rm -rf /var/cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo global8 >&2 && sudo rmdir /var/cache/gitpack/repo/github.com/dominiksalvet/ &&
echo global9 >&2 && sudo rmdir /var/cache/gitpack/repo/github.com/ &&
echo global10 >&2 && sudo rmdir /var/cache/gitpack/repo/ &&
echo global11 >&2 && sudo rmdir /var/cache/gitpack/ &&
echo global12 >&2 && sudo rm /var/lib/gitpack/status.bak &&
echo global13 >&2 && test ! "$(sudo cat /var/lib/gitpack/status)" &&
echo global14 >&2 && sudo rm /var/lib/gitpack/status &&
echo global15 >&2 && sudo rmdir /var/lib/gitpack/ &&
echo global16 >&2 && sudo rm /var/log/gitpack/gitpack.log &&
echo global17 >&2 && sudo rmdir /var/log/gitpack/ &&

#-------------------------------------------------------------------------------
# LOCAL INSTALLATION
#-------------------------------------------------------------------------------
# Checks whether the current commit of GitPack can install itself locally.
#-------------------------------------------------------------------------------

# install, check status and uninstall it
echo local1 >&2 && gitpack_out="$(src/gitpack install -h github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo local2 >&2 && test "$gitpack_out" = "[install] github.com/dominiksalvet/gitpack $SHORT_TRAVIS_COMMIT" &&
echo local3 >&2 && gitpack_out="$(src/gitpack status -oh github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo local4 >&2 && test "$gitpack_out" = "[ok] github.com/dominiksalvet/gitpack $SHORT_TRAVIS_COMMIT" &&
echo local5 >&2 && gitpack_out="$(src/gitpack uninstall -oh github.com/dominiksalvet/gitpack)" &&
echo local6 >&2 && test "$gitpack_out" = "[uninstall] github.com/dominiksalvet/gitpack $SHORT_TRAVIS_COMMIT" &&

# create all local GitPack files
echo local7 >&2 && rm -rf "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo local8 >&2 && rmdir "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo local9 >&2 && rmdir "$HOME"/.cache/gitpack/repo/github.com/ &&
echo local10 >&2 && rmdir "$HOME"/.cache/gitpack/repo/ &&
echo local11 >&2 && rmdir "$HOME"/.cache/gitpack/ &&
echo local12 >&2 && rm "$HOME"/.local/share/gitpack/status.bak &&
echo local13 >&2 && test ! "$(cat "$HOME"/.local/share/gitpack/status)" &&
echo local14 >&2 && rm "$HOME"/.local/share/gitpack/status &&
echo local15 >&2 && rm "$HOME"/.local/share/gitpack/gitpack.log &&
echo local16 >&2 && rmdir "$HOME"/.local/share/gitpack/ &&

#-------------------------------------------------------------------------------
# USAGE
#-------------------------------------------------------------------------------
# Checks exit codes and output of basic user usage and related circumstances.
#-------------------------------------------------------------------------------

# check GitPack commands
echo command1 >&2 && src/gitpack list &&
echo command2 >&2 && src/gitpack clean &&
echo command3 >&2 && gitpack_out="$(src/gitpack paths)" &&
echo command4 >&2 && echo "$gitpack_out" | grep -Fx 'log '"$HOME"/.local/share/gitpack/ &&
echo command5 >&2 && echo "$gitpack_out" | grep -Fx 'cache '"$HOME"/.cache/gitpack/ &&
echo command6 >&2 && echo "$gitpack_out" | grep -Fx 'state '"$HOME"/.local/share/gitpack/ &&
echo command7 >&2 && src/gitpack about &&
echo command8 >&2 && src/gitpack help &&

# install older version
echo install1 >&2 && gitpack_out="$(src/gitpack status github.com/dominiksalvet/gitpack=0.1.0)" &&
echo install2 >&2 && test "$gitpack_out" = '[nothing] github.com/dominiksalvet/gitpack -> 0.1.0' &&
echo install3 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo install4 >&2 && test "$gitpack_out" = '[install] github.com/dominiksalvet/gitpack 0.1.0' &&
echo install5 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo install6 >&2 && test "$gitpack_out" = '[installed] github.com/dominiksalvet/gitpack 0.1.0' &&
echo install7 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo install8 >&2 && test "$gitpack_out" = '[ok] github.com/dominiksalvet/gitpack 0.1.0' &&
echo install9 >&2 && gitpack_out="$(src/gitpack list)" &&
echo install10 >&2 && test "$gitpack_out" = 'github.com/dominiksalvet/gitpack 0.1.0' &&
# check installed files
echo install11 >&2 && test -x "$HOME"/.local/bin/gitpack &&

# install current version + test status file recovery
echo update1 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack)" &&
echo update2 >&2 && echo "$gitpack_out" | grep -F '[older] github.com/dominiksalvet/gitpack 0.1.0' &&
echo update3 >&2 && rm "$HOME"/.local/share/gitpack/status &&
echo update4 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack)" &&
echo update5 >&2 && echo "$gitpack_out" | grep -F '[update] github.com/dominiksalvet/gitpack' &&
echo update6 >&2 && rm "$HOME"/.local/share/gitpack/status &&
echo update7 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack)" &&
echo update8 >&2 && echo "$gitpack_out" | grep -F '[installed] github.com/dominiksalvet/gitpack' &&
echo update9 >&2 && rm "$HOME"/.local/share/gitpack/status &&
echo update10 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack)" &&
echo update11 >&2 && echo "$gitpack_out" | grep -F '[ok] github.com/dominiksalvet/gitpack' &&
echo update12 >&2 && rm "$HOME"/.local/share/gitpack/status &&
echo update13 >&2 && gitpack_out="$(src/gitpack list)" &&
echo update14 >&2 && echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/gitpack' &&
echo update15 >&2 && rm "$HOME"/.local/share/gitpack/status &&
# check installed files
echo update16 >&2 && test -x "$HOME"/.local/bin/gitpack &&
echo update17 >&2 && test -f "$HOME"/.bash_completion.d/gitpack-completion.bash &&
echo update18 >&2 && test ! -x "$HOME"/.bash_completion.d/gitpack-completion.bash &&

# downgrade to older version + test hash mode
echo downgrade1 >&2 && gitpack_out="$(src/gitpack status -oh github.com/dominiksalvet/gitpack=0.1.0)" &&
echo downgrade2 >&2 && echo "$gitpack_out" | grep -F '[newer] github.com/dominiksalvet/gitpack' &&
echo downgrade3 >&2 && gitpack_out="$(src/gitpack install -oh github.com/dominiksalvet/gitpack=0.1.0)" &&
echo downgrade4 >&2 && echo "$gitpack_out" | grep -F '[downgrade] github.com/dominiksalvet/gitpack 5bc956f' &&
echo downgrade5 >&2 && gitpack_out="$(src/gitpack install -oh github.com/dominiksalvet/gitpack=0.1.0)" &&
echo downgrade6 >&2 && test "$gitpack_out" = '[installed] github.com/dominiksalvet/gitpack 5bc956f' &&
echo downgrade7 >&2 && gitpack_out="$(src/gitpack status -oh github.com/dominiksalvet/gitpack=0.1.0)" &&
echo downgrade8 >&2 && test "$gitpack_out" = '[ok] github.com/dominiksalvet/gitpack 5bc956f' &&
echo downgrade9 >&2 && gitpack_out="$(src/gitpack list)" &&
echo downgrade10 >&2 && test "$gitpack_out" = 'github.com/dominiksalvet/gitpack 0.1.0' &&
# check installed files
echo downgrade11 >&2 && test -x "$HOME"/.local/bin/gitpack &&
echo downgrade12 >&2 && test ! -e "$HOME"/.bash_completion.d/gitpack-completion.bash &&

# uninstall + test hash mode
echo uninstall1 >&2 && gitpack_out="$(src/gitpack uninstall -oh github.com/dominiksalvet/gitpack)" &&
echo uninstall2 >&2 && test "$gitpack_out" = '[uninstall] github.com/dominiksalvet/gitpack 5bc956f' &&
echo uninstall3 >&2 && gitpack_out="$(src/gitpack uninstall -oh github.com/dominiksalvet/gitpack)" &&
echo uninstall4 >&2 && test "$gitpack_out" = '[uninstalled] github.com/dominiksalvet/gitpack' &&
echo uninstall5 >&2 && gitpack_out="$(src/gitpack status -oh github.com/dominiksalvet/gitpack)" &&
echo uninstall6 >&2 && echo "$gitpack_out" | grep -F '[nothing] github.com/dominiksalvet/gitpack' &&
echo uninstall7 >&2 && gitpack_out="$(src/gitpack list)" &&
echo uninstall8 >&2 && test ! "$gitpack_out" &&
# check installed files
echo uninstall9 >&2 && test ! -e "$HOME"/.local/bin/gitpack &&
echo uninstall10 >&2 && test ! -e "$HOME"/.bash_completion.d/gitpack-completion.bash &&

# expected to fail
echo xfail1 >&2 && ! src/gitpack 2>/dev/null && # no argument
echo xfail2 >&2 && ! src/gitpack duck 2>/dev/null && # invalid argument
echo xfail3 >&2 && ! src/gitpack -o 2>/dev/null && # invalid argument
echo xfail4 >&2 && ! src/gitpack -h 2>/dev/null && # invalid argument
echo xfail5 >&2 && ! src/gitpack status 2>/dev/null && # no URL
echo xfail6 >&2 && ! src/gitpack status -o 2>/dev/null && # no URL
echo xfail7 >&2 && ! src/gitpack status -h 2>/dev/null && # no URL
echo xfail8 >&2 && ! src/gitpack status -z github.com/dominiksalvet/gitpack 2>/dev/null && # invalid option
# unsupported URLs
echo xfail9 >&2 && ! src/gitpack status . 2>/dev/null &&
echo xfail10 >&2 && ! src/gitpack status .. 2>/dev/null &&
echo xfail11 >&2 && ! src/gitpack status xfail/. 2>/dev/null &&
echo xfail12 >&2 && ! src/gitpack status xfail/.. 2>/dev/null &&
echo xfail13 >&2 && ! src/gitpack status ./xfail 2>/dev/null &&
echo xfail14 >&2 && ! src/gitpack status ../xfail 2>/dev/null &&
echo xfail15 >&2 && ! src/gitpack status xfail/./xfail 2>/dev/null &&
echo xfail16 >&2 && ! src/gitpack status xfail/../xfail 2>/dev/null &&
echo xfail17 >&2 && ! src/gitpack status 'x fail' 2>/dev/null &&
echo xfail18 >&2 && ! src/gitpack status 'x
fail' 2>/dev/null &&

#-------------------------------------------------------------------------------
# FILES
#-------------------------------------------------------------------------------
# This test checks the correct existence and contents of GitPack files.
#-------------------------------------------------------------------------------

# existence of log files
echo logfiles1 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo logfiles2 >&2 && test -r "$HOME"/.local/share/gitpack/ &&
echo logfiles3 >&2 && test -w "$HOME"/.local/share/gitpack/ &&
echo logfiles4 >&2 && test -x "$HOME"/.local/share/gitpack/ &&
echo logfiles5 >&2 && test -f "$HOME"/.local/share/gitpack/gitpack.log &&
echo logfiles6 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo logfiles7 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo logfiles8 >&2 && test ! -x "$HOME"/.local/share/gitpack/gitpack.log &&

# existing cache files
echo cachefiles1 >&2 && test -d "$HOME"/.cache/gitpack/ &&
echo cachefiles2 >&2 && test -r "$HOME"/.cache/gitpack/ &&
echo cachefiles3 >&2 && test -w "$HOME"/.cache/gitpack/ &&
echo cachefiles4 >&2 && test -x "$HOME"/.cache/gitpack/ &&
echo cachefiles5 >&2 && test -d "$HOME"/.cache/gitpack/repo/ &&
echo cachefiles6 >&2 && test -r "$HOME"/.cache/gitpack/repo/ &&
echo cachefiles7 >&2 && test -w "$HOME"/.cache/gitpack/repo/ &&
echo cachefiles8 >&2 && test -x "$HOME"/.cache/gitpack/repo/ &&
echo cachefiles9 >&2 && test -d "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo cachefiles10 >&2 && test -r "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo cachefiles11 >&2 && test -w "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo cachefiles12 >&2 && test -x "$HOME"/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
# nonexistent cache files
echo cachefiles13 >&2 && test ! -d "$HOME"/.cache/gitpack/repo/xfail/ &&
echo cachefiles14 >&2 && test ! -d "$HOME"/.cache/gitpack/repo/xfail/xfail/ &&
echo cachefiles15 >&2 && test ! -d "$HOME"/.cache/gitpack/repo/'x fail'/ &&
echo cachefiles16 >&2 && test ! -d "$HOME"/.cache/gitpack/repo/'x
fail'/ &&

# existence of state files
echo statefiles1 >&2 && test -r "$HOME"/.local/share/gitpack/status &&
echo statefiles2 >&2 && test -w "$HOME"/.local/share/gitpack/status &&
echo statefiles3 >&2 && test ! -x "$HOME"/.local/share/gitpack/status &&
echo statefiles4 >&2 && test -r "$HOME"/.local/share/gitpack/status.bak &&
echo statefiles5 >&2 && test -w "$HOME"/.local/share/gitpack/status.bak &&
echo statefiles6 >&2 && test ! -x "$HOME"/.local/share/gitpack/status.bak &&

# contents of status file
echo status1 >&2 && test ! "$(cat "$HOME"/.local/share/gitpack/status)" &&

# contents of log file
echo log1 >&2 && test "$(grep -Fc '[log]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 36 &&
echo log2 >&2 && test "$(grep -Fc '[fail]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 14 &&
echo log3 >&2 && test "$(grep -Fc '[signal]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log4 >&2 && test "$(grep -Fc '[exit]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 36 &&
echo log5 >&2 && test "$(grep -Fc '[list]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 5 &&
echo log6 >&2 && test "$(grep -Fc '[clean]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo log7 >&2 && test "$(grep -Fc '[paths]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo log8 >&2 && test "$(grep -Fc '[action]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 25 &&
echo log9 >&2 && test "$(grep -Fc '[url]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 25 &&
echo log10 >&2 && test "$(grep -Fc '[repo]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo log11 >&2 && test "$(grep -Fc '[execute]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo log12 >&2 && test "$(grep -Fc '[deps]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log13 >&2 && test "$(grep -Fc '[db]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 36 &&
echo log14 >&2 && test "$(grep -Fc '[get]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo log15 >&2 && test "$(grep -Fc '[insert]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo log16 >&2 && test "$(grep -Fc '[delete]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo log17 >&2 && test "$(grep -Fc '[backup]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 22 &&
echo log18 >&2 && test "$(grep -Fc '[precp]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo log19 >&2 && test "$(grep -Fc '[cp]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo log20 >&2 && test "$(grep -Fc '[postcp]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log21 >&2 && test "$(grep -Fc '[prerm]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log22 >&2 && test "$(grep -Fc '[rm]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo log23 >&2 && test "$(grep -Fc '[postrm]' "$HOME"/.local/share/gitpack/gitpack.log)" -eq 0 &&
echo log24 >&2 && test "$(wc -l < "$HOME"/.local/share/gitpack/gitpack.log)" -eq 262 &&

# clean files (it affects log and cache files)
echo clean1 >&2 && src/gitpack clean &&

# existence of log files
echo clean2 >&2 && test -d "$HOME"/.local/share/gitpack/ &&
echo clean3 >&2 && test -r "$HOME"/.local/share/gitpack/ &&
echo clean4 >&2 && test -w "$HOME"/.local/share/gitpack/ &&
echo clean5 >&2 && test -x "$HOME"/.local/share/gitpack/ &&
echo clean6 >&2 && test -f "$HOME"/.local/share/gitpack/gitpack.log &&
echo clean7 >&2 && test -r "$HOME"/.local/share/gitpack/gitpack.log &&
echo clean8 >&2 && test -w "$HOME"/.local/share/gitpack/gitpack.log &&
echo clean9 >&2 && test ! -x "$HOME"/.local/share/gitpack/gitpack.log &&

# existence of cache files
echo clean10 >&2 && test ! -d "$HOME"/.cache/gitpack/
