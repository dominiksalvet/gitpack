#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($GITPACK clean)" && # it must delete cache
test ! -d "$HOME"/.cache/gitpack/ &&

out2="$($SUDO_GITPACK clean)" &&
test ! -d /var/cache/gitpack/ &&

: "$out1" "$out2" # API already tested, no output check
