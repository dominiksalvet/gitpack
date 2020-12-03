#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out="$($GITPACK list)" && # must succeed
test ! "$out" && # must be empty

out="$($GITPACK install "$URL")" &&
test "$out" = ">>> running install for $URL
<<< done; successfully installed" &&

out="$($GITPACK list)" &&
test "$out" = "$URL $VERSION" &&

out="$($GITPACK -h list)" &&
test "$out" = "$URL $VERSION_SHORT_HASH" &&

out="$($GITPACK -H list)" &&
test "$out" = "$URL $VERSION_HASH" &&

out="$($GITPACK uninstall "$URL")" &&
test "$out" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

out="$($GITPACK list)" &&
test ! "$out" # empty again
