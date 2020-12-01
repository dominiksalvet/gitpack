#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out="$($GITPACK install "$URL")" &&
test "$out" = ">>> running install for $URL
<<< done; successfully installed" &&

out="$($GITPACK status "$URL=$OLD_VERSION")" &&
test "$out" = ">>> running status for $URL=$OLD_VERSION
<<< installed $VERSION is newer than candidate $OLD_VERSION" &&

out="$($GITPACK install "$URL=$OLD_VERSION")" &&
test "$out" = ">>> running install for $URL=$OLD_VERSION
<<< done; successfully downgraded" &&

out="$($GITPACK uninstall "$URL")" &&
test "$out" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"