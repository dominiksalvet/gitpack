#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out="$($GITPACK install "$URL")" &&
test "$out" = ">>> running install for $URL
<<< done; successfully installed" &&

out="$($GITPACK install "$URL")" && # must be already installed
test "$out" = ">>> running install for $URL
<<< already installed" &&

out="$($GITPACK install "$URL=$VERSION")" &&
test "$out" = ">>> running install for $URL=$VERSION
<<< already installed" &&

out="$($GITPACK install "$URL=$VERSION_HASH")" &&
test "$out" = ">>> running install for $URL=$VERSION_HASH
<<< already installed" &&

out="$($GITPACK status "$URL")" &&
test "$out" = ">>> running status for $URL
<<< candidate $VERSION already installed" &&

out="$($GITPACK uninstall "$URL")" &&
test "$out" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

out="$($GITPACK uninstall "$URL")" && # must be already uninstalled
test "$out" = ">>> running uninstall for $URL
<<< already uninstalled" &&

out="$($GITPACK status "$URL")" &&
test "$out" = ">>> running status for $URL
<<< not installed; candidate is $VERSION" &&

# raw URL mode
out="$($GITPACK -r install "https://$URL.git")" &&
test "$out" = ">>> running install for https://$URL.git
<<< done; successfully installed" &&

out="$($GITPACK -r uninstall "https://$URL.git")" &&
test "$out" = ">>> running uninstall for https://$URL.git
<<< done; successfully uninstalled"
