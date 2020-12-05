#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($GITPACK install "$URL")" &&
test "$out1" = ">>> running install for $URL
<<< done; successfully installed" &&

out2="$($GITPACK status "$URL=$OLD_VERSION")" &&
test "$out2" = ">>> running status for $URL=$OLD_VERSION
<<< installed $VERSION is newer than candidate $OLD_VERSION" &&

out3="$($GITPACK install "$URL=$OLD_VERSION")" &&
test "$out3" = ">>> running install for $URL=$OLD_VERSION
<<< done; successfully downgraded" &&

out4="$($GITPACK uninstall "$URL")" &&
test "$out4" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

# raw URL mode
out5="$($GITPACK -r install "https://$URL.git")" &&
test "$out5" = ">>> running install for https://$URL.git
<<< done; successfully installed" &&

out6="$($GITPACK -r install "https://$URL.git=$OLD_VERSION")" &&
test "$out6" = ">>> running install for https://$URL.git=$OLD_VERSION
<<< done; successfully downgraded" &&

out7="$($GITPACK -r uninstall "https://$URL.git")" &&
test "$out7" = ">>> running uninstall for https://$URL.git
<<< done; successfully uninstalled"
