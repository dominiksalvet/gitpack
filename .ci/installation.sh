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

# install GitPack from the current commit globally
echo global1 && gitpack_out="$(sudo src/gitpack install github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo global2 && echo "$gitpack_out" | grep '^\[install\]' &&
# check whether installed globally
echo global3 && gitpack_out="$(sudo gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo global4 && echo "$gitpack_out" | grep '^\[ok\]' &&
# check whether uninstallation works
echo global5 && gitpack_out="$(sudo gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo global6 && echo "$gitpack_out" | grep '^\[uninstall\]' &&

# clean created files
echo global7 && sudo rm /var/log/gitpack/gitpack.log &&
echo global8 && sudo rmdir /var/log/gitpack/ &&
echo global9 && sudo rm -rf /var/cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo global10 && sudo rmdir /var/cache/gitpack/repo/github.com/dominiksalvet/ &&
echo global11 && sudo rmdir /var/cache/gitpack/repo/github.com/ &&
echo global12 && sudo rmdir /var/cache/gitpack/repo/ &&
echo global13 && sudo rmdir /var/cache/gitpack/ &&
echo global14 && test ! "$(sudo cat /var/lib/gitpack/status)" &&
echo global15 && sudo rm /var/lib/gitpack/status &&
echo global16 && sudo rm /var/lib/gitpack/status.bak &&
echo global17 && sudo rmdir /var/lib/gitpack/ &&

#-------------------------------------------------------------------------------
# LOCAL INSTALLATION
#-------------------------------------------------------------------------------

# install GitPack from the current commit locally
echo local1 && gitpack_out="$(src/gitpack install github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo local2 && echo "$gitpack_out" | grep '^\[install\]' &&
# check whether installed locally
echo local3 && gitpack_out="$(gitpack status github.com/dominiksalvet/gitpack="$TRAVIS_COMMIT")" &&
echo local4 && echo "$gitpack_out" | grep '^\[ok\]' &&
# check whether uninstallation works
echo local5 && gitpack_out="$(gitpack uninstall github.com/dominiksalvet/gitpack)" &&
echo local6 && echo "$gitpack_out" | grep '^\[uninstall\]' &&

# clean created files
echo local7 && rm ~/.local/share/gitpack/gitpack.log &&
echo local8 && rm -rf ~/.cache/gitpack/repo/github.com/dominiksalvet/gitpack/ &&
echo local9 && rmdir ~/.cache/gitpack/repo/github.com/dominiksalvet/ &&
echo local10 && rmdir ~/.cache/gitpack/repo/github.com/ &&
echo local11 && rmdir ~/.cache/gitpack/repo/ &&
echo local12 && rmdir ~/.cache/gitpack/ &&
echo local13 && test ! "$(cat ~/.local/share/gitpack/status)" &&
echo local14 && rm ~/.local/share/gitpack/status &&
echo local15 && rm ~/.local/share/gitpack/status.bak &&
echo local16 && rmdir ~/.local/share/gitpack/
