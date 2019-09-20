#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Installs and completely uninstalls GitPack globally and then locally.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# GLOBAL INSTALLATION
#-------------------------------------------------------------------------------

if [ "$TRAVIS_OS_NAME" != windows ]; then # windows git bash shell does not have sudo command
    # install GitPack from the current commit globally
    echo global1 >&2 && gitpack_out="$(sudo src/gitpack install github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
    echo global2 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&
    # check whether installed globally
    echo global3 >&2 && gitpack_out="$(sudo gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
    echo global4 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
    # check whether uninstallation works
    echo global5 >&2 && gitpack_out="$(sudo gitpack uninstall github.com/dominiksalvet/gitpack)" &&
    echo global6 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]' &&

    # clean created files
    echo global7 >&2 && sudo rm /var/log/gitpack/gitpack.log &&
    echo global8 >&2 && sudo rmdir /var/log/gitpack/ &&
    echo global9 >&2 && sudo rm -rf /var/cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
    echo global10 >&2 && sudo rmdir /var/cache/gitpack/repo/github.com/dominiksalvet/ &&
    echo global11 >&2 && sudo rmdir /var/cache/gitpack/repo/github.com/ &&
    echo global12 >&2 && sudo rmdir /var/cache/gitpack/repo/ &&
    echo global13 >&2 && sudo rmdir /var/cache/gitpack/ &&
    echo global14 >&2 && sudo test ! "$(cat /var/lib/gitpack/status)" &&
    echo global15 >&2 && sudo rm /var/lib/gitpack/status &&
    echo global16 >&2 && sudo rm /var/lib/gitpack/status.bak &&
    echo global17 >&2 && sudo rmdir /var/lib/gitpack/
fi &&

#-------------------------------------------------------------------------------
# LOCAL INSTALLATION
#-------------------------------------------------------------------------------

# install GitPack from the current commit locally
echo local1 >&2 && gitpack_out="$(src/gitpack install github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo local2 >&2 && echo "$gitpack_out" | grep '^\[install\]' &&
# check whether installed locally
echo local3 >&2 && gitpack_out="$(gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo local4 >&2 && echo "$gitpack_out" | grep '^\[ok\]' &&
# check whether uninstallation works
echo local5 >&2 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo local6 >&2 && echo "$gitpack_out" | grep '^\[uninstall\]' &&

# clean created files
echo local7 >&2 && rm ~/.local/share/gitpack/gitpack.log &&
echo local8 >&2 && rm -rf ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo local9 >&2 && rmdir ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo local10 >&2 && rmdir ~/.cache/gitpack/repo/github.com/ &&
echo local11 >&2 && rmdir ~/.cache/gitpack/repo/ &&
echo local12 >&2 && rmdir ~/.cache/gitpack/ &&
echo local13 >&2 && test ! "$(cat ~/.local/share/gitpack/status)" &&
echo local14 >&2 && rm ~/.local/share/gitpack/status &&
echo local15 >&2 && rm ~/.local/share/gitpack/status.bak &&
echo local16 >&2 && rmdir ~/.local/share/gitpack/
