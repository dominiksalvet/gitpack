#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out="$($GITPACK install "$URL=$OLD_VERSION")" &&
test "$out" = ">>> running install for $URL=$OLD_VERSION
<<< done; successfully installed" &&

out="$($GITPACK status "$URL=$OLD_VERSION")" &&
test "$out" = ">>> running status for $URL=$OLD_VERSION
<<< candidate $OLD_VERSION already installed" &&

out="$($GITPACK status "$URL")" &&
test "$out" = ">>> running status for $URL
<<< installed $OLD_VERSION is older than candidate $VERSION" &&

out="$($GITPACK install "$URL")" &&
test "$out" = ">>> running install for $URL
<<< done; successfully updated" &&

out="$($GITPACK uninstall "$URL")" &&
test "$out" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

# raw URL mode
out="$($GITPACK -r install "https://$URL.git=$OLD_VERSION")" &&
test "$out" = ">>> running install for https://$URL.git=$OLD_VERSION
<<< done; successfully installed" &&

out="$($GITPACK -r install "https://$URL.git")" &&
test "$out" = ">>> running install for https://$URL.git
<<< done; successfully updated" &&

out="$($GITPACK -r uninstall "https://$URL.git")" &&
test "$out" = ">>> running uninstall for https://$URL.git
<<< done; successfully uninstalled"
