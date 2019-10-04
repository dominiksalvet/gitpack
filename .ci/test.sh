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
# GLOBAL INSTALLATION
#-------------------------------------------------------------------------------
# Checks whether the current commit of GitPack can install itself globally.
#-------------------------------------------------------------------------------

# copy current repository to global GitPack cache
echo global1 >&2 && sudo mkdir -p /var/cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo global2 >&2 && sudo cp -R ./ /var/cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&

# install, check status and uninstall it
echo global3 >&2 && gitpack_out="$(sudo src/gitpack install -o github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo global4 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&
echo global5 >&2 && gitpack_out="$(sudo src/gitpack status -o github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo global6 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo global7 >&2 && gitpack_out="$(sudo src/gitpack uninstall -o github.com/dominiksalvet/gitpack)" &&
echo global8 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]' &&

# clean all global GitPack files
echo global9 >&2 && sudo rm /var/log/gitpack/gitpack.log &&
echo global10 >&2 && sudo rmdir /var/log/gitpack/ &&
echo global11 >&2 && sudo rm -rf /var/cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo global12 >&2 && sudo rmdir /var/cache/gitpack/repo/github.com/dominiksalvet/ &&
echo global13 >&2 && sudo rmdir /var/cache/gitpack/repo/github.com/ &&
echo global14 >&2 && sudo rmdir /var/cache/gitpack/repo/ &&
echo global15 >&2 && sudo rmdir /var/cache/gitpack/ &&
echo global16 >&2 && test ! "$(sudo cat /var/lib/gitpack/status)" &&
echo global17 >&2 && sudo rm /var/lib/gitpack/status &&
echo global18 >&2 && sudo rm /var/lib/gitpack/status.bak &&
echo global19 >&2 && sudo rmdir /var/lib/gitpack/ &&

#-------------------------------------------------------------------------------
# LOCAL INSTALLATION
#-------------------------------------------------------------------------------
# Checks whether the current commit of GitPack can install itself locally.
#-------------------------------------------------------------------------------

# copy current repository to local GitPack cache
echo local1 >&2 && mkdir -p ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo local2 >&2 && cp -R ./ ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&

# install, check status and uninstall it
echo local3 >&2 && gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo local4 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&
echo local5 >&2 && gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo local6 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
echo local7 >&2 && gitpack_out="$(src/gitpack uninstall -o github.com/dominiksalvet/gitpack)" &&
echo local8 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]' &&

# create all local GitPack files
echo local9 >&2 && rm ~/.local/share/gitpack/gitpack.log &&
echo local10 >&2 && rm -rf ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo local11 >&2 && rmdir ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo local12 >&2 && rmdir ~/.cache/gitpack/repo/github.com/ &&
echo local13 >&2 && rmdir ~/.cache/gitpack/repo/ &&
echo local14 >&2 && rmdir ~/.cache/gitpack/ &&
echo local15 >&2 && test ! "$(cat ~/.local/share/gitpack/status)" &&
echo local16 >&2 && rm ~/.local/share/gitpack/status &&
echo local17 >&2 && rm ~/.local/share/gitpack/status.bak &&
echo local18 >&2 && rmdir ~/.local/share/gitpack/ &&

#-------------------------------------------------------------------------------
# USAGE
#-------------------------------------------------------------------------------
# Checks exit codes and output of basic user usage and related circumstances.
#-------------------------------------------------------------------------------

# check GitPack commands
src/gitpack list &&
src/gitpack clean &&
src/gitpack about &&
src/gitpack help &&

# install older version
gitpack_out="$(src/gitpack status github.com/dominiksalvet/gitpack=0.1.0)" &&
echo "$gitpack_out" | grep '^\[nothing\]' &&
gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo "$gitpack_out" | grep '^\[install\]' &&
gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo "$gitpack_out" | grep '^\[installed\]' &&
gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
gitpack_out="$(src/gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/gitpack' &&
# check installed files
test -x ~/.local/bin/gitpack &&

# install current version + test status file recovery
gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[older\]' &&
rm ~/.local/share/gitpack/status &&
gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[update\]' &&
rm ~/.local/share/gitpack/status &&
gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[installed\]' &&
rm ~/.local/share/gitpack/status &&
gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
rm ~/.local/share/gitpack/status &&
gitpack_out="$(src/gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/gitpack' &&
rm ~/.local/share/gitpack/status &&
# check installed files
test -x ~/.local/bin/gitpack &&
test -f ~/.bash_completion.d/gitpack-completion.bash &&
test ! -x ~/.bash_completion.d/gitpack-completion.bash &&

# downgrade to older version
gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo "$gitpack_out" | grep '^\[newer\]' &&
gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo "$gitpack_out" | grep '^\[downgrade\]' &&
gitpack_out="$(src/gitpack install -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo "$gitpack_out" | grep '^\[installed\]' &&
gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack=0.1.0)" &&
echo "$gitpack_out" | grep '^\[ok\]' &&
gitpack_out="$(src/gitpack list)" &&
echo "$gitpack_out" | grep -F 'github.com/dominiksalvet/gitpack' &&
# check installed files
test -x ~/.local/bin/gitpack &&
test ! -e ~/.bash_completion.d/gitpack-completion.bash &&

# uninstall
gitpack_out="$(src/gitpack uninstall -o github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[uninstall\]' &&
gitpack_out="$(src/gitpack uninstall -o github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[uninstalled\]' &&
gitpack_out="$(src/gitpack status -o github.com/dominiksalvet/gitpack)" &&
echo "$gitpack_out" | grep '^\[nothing\]' &&
# check installed files
test ! -e ~/.local/bin/gitpack &&
test ! -e ~/.bash_completion.d/gitpack-completion.bash &&

# expected to fail
! gitpack_out="$(src/gitpack)" && # no argument
! gitpack_out="$(src/gitpack duck)" && # invalid argument
! gitpack_out="$(src/gitpack -o)" && # invalid argument
! gitpack_out="$(src/gitpack status)" && # no URL
! gitpack_out="$(src/gitpack status -o)" && # no URL
! gitpack_out="$(src/gitpack status -w github.com/dominiksalvet/gitpack)" && # invalid option
# unsupported URL
! gitpack_out="$(src/gitpack status github.com 2>&1)" &&
echo "$gitpack_out" | grep '^<ERROR>' &&
! gitpack_out="$(src/gitpack status github.com/a 2>&1)" &&
echo "$gitpack_out" | grep '^<ERROR>' &&
! gitpack_out="$(src/gitpack status github.com/a/b/c 2>&1)" &&
echo "$gitpack_out" | grep '^<ERROR>' &&

#-------------------------------------------------------------------------------
# FILES
#-------------------------------------------------------------------------------
# This test checks the correct existence and contents of GitPack files.
#-------------------------------------------------------------------------------

# existence of log files
test -d ~/.local/share/gitpack/ &&
test -r ~/.local/share/gitpack/ &&
test -w ~/.local/share/gitpack/ &&
test -x ~/.local/share/gitpack/ &&
test -f ~/.local/share/gitpack/gitpack.log &&
test -r ~/.local/share/gitpack/gitpack.log &&
test -w ~/.local/share/gitpack/gitpack.log &&
test ! -x ~/.local/share/gitpack/gitpack.log &&

# existence of cache files
test -d ~/.cache/gitpack/ &&
test -r ~/.cache/gitpack/ &&
test -w ~/.cache/gitpack/ &&
test -x ~/.cache/gitpack/ &&
test -d ~/.cache/gitpack/repo/ &&
test -r ~/.cache/gitpack/repo/ &&
test -w ~/.cache/gitpack/repo/ &&
test -x ~/.cache/gitpack/repo/ &&
test -d ~/.cache/gitpack/repo/github.com/ &&
test -r ~/.cache/gitpack/repo/github.com/ &&
test -w ~/.cache/gitpack/repo/github.com/ &&
test -x ~/.cache/gitpack/repo/github.com/ &&
test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
test -r ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
test -w ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
test -x ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
test -d ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
test -r ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
test -w ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
test -x ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
test ! -d ~/.cache/gitpack/repo/github.com/a/ &&

# existence of state files
test -r ~/.local/share/gitpack/status &&
test -w ~/.local/share/gitpack/status &&
test ! -x ~/.local/share/gitpack/status &&
test -r ~/.local/share/gitpack/status.bak &&
test -w ~/.local/share/gitpack/status.bak &&
test ! -x ~/.local/share/gitpack/status.bak &&

# contents of status file
test ! "$(cat ~/.local/share/gitpack/status)" &&

# contents of log file
test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 26 &&
test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 26 &&
test "$(grep -Fc '[backup]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
test "$(grep -Fc '[fail]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
test "$(grep -Fc '[signal]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 26 &&
test "$(grep -Fc '[list]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
test "$(grep -Fc '[clean]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
test "$(grep -Fc '[action]' ~/.local/share/gitpack/gitpack.log)" -eq 18 &&
test "$(grep -Fc '[url]' ~/.local/share/gitpack/gitpack.log)" -eq 18 &&
test "$(grep -Fc '[refresh]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
test "$(grep -Fc '[execute]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
test "$(grep -Fc '[deps]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
test "$(grep -Fc '[get]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
test "$(grep -Fc '[insert]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
test "$(grep -Fc '[delete]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
test "$(grep -Fc '[precp]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
test "$(grep -Fc '[cp]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
test "$(grep -Fc '[postcp]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
test "$(grep -Fc '[prerm]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
test "$(grep -Fc '[rm]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
test "$(grep -Fc '[postrm]' ~/.local/share/gitpack/gitpack.log)" -eq 0 &&
test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 203 &&

# clean files
src/gitpack clean &&

# existence of log files
test -d ~/.local/share/gitpack/ &&
test -r ~/.local/share/gitpack/ &&
test -w ~/.local/share/gitpack/ &&
test -x ~/.local/share/gitpack/ &&
test -f ~/.local/share/gitpack/gitpack.log &&
test -r ~/.local/share/gitpack/gitpack.log &&
test -w ~/.local/share/gitpack/gitpack.log &&
test ! -x ~/.local/share/gitpack/gitpack.log &&

# existence of cache files
test ! -d ~/.cache/gitpack/
