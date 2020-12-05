#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($GITPACK install "$URL")" &&
test "$out1" = ">>> running install for $URL
<<< done; successfully installed" &&

out2="$($GITPACK install "$URL")" && # must be already installed
test "$out2" = ">>> running install for $URL
<<< already installed" &&

out3="$($GITPACK install "$URL=$VERSION")" &&
test "$out3" = ">>> running install for $URL=$VERSION
<<< already installed" &&

out4="$($GITPACK install "$URL=$VERSION_HASH")" &&
test "$out4" = ">>> running install for $URL=$VERSION_HASH
<<< already installed" &&

out5="$($GITPACK status "$URL")" &&
test "$out5" = ">>> running status for $URL
<<< candidate $VERSION already installed" &&

out6="$($GITPACK uninstall "$URL")" &&
test "$out6" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

out7="$($GITPACK uninstall "$URL")" && # must be already uninstalled
test "$out7" = ">>> running uninstall for $URL
<<< already uninstalled" &&

out8="$($GITPACK status "$URL")" &&
test "$out8" = ">>> running status for $URL
<<< not installed; candidate is $VERSION" &&

# raw URL mode
out9="$($GITPACK -r install "https://$URL.git")" &&
test "$out9" = ">>> running install for https://$URL.git
<<< done; successfully installed" &&

out10="$($GITPACK -r uninstall "https://$URL.git")" &&
test "$out10" = ">>> running uninstall for https://$URL.git
<<< done; successfully uninstalled"
