#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($GITPACK list)" && # must succeed
test ! "$out1" && # must be empty

out2="$($GITPACK install "$URL")" &&
test "$out2" = ">>> running install for $URL
<<< done; successfully installed" &&

out3="$($GITPACK list)" &&
test "$out3" = "$URL $VERSION" &&

out4="$($GITPACK -h list)" &&
test "$out4" = "$URL $VERSION_SHORT_HASH" &&

out5="$($GITPACK -H list)" &&
test "$out5" = "$URL $VERSION_HASH" &&

out6="$($GITPACK uninstall "$URL")" &&
test "$out6" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

out7="$($GITPACK list)" &&
test ! "$out7" # empty again
