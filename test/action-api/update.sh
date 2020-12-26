#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($GITPACK install "$URL=$OLD_VERSION")"
test "$out1" = ">>> running install for $URL=$OLD_VERSION
<<< done; successfully installed"

out2="$($GITPACK status "$URL=$OLD_VERSION")"
test "$out2" = ">>> running status for $URL=$OLD_VERSION
<<< candidate $OLD_VERSION already installed"

out3="$($GITPACK status "$URL")"
test "$out3" = ">>> running status for $URL
<<< installed $OLD_VERSION is older than candidate $VERSION"

out4="$($GITPACK install "$URL")"
test "$out4" = ">>> running install for $URL
<<< done; successfully updated"

out5="$($GITPACK uninstall "$URL")"
test "$out5" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"

# raw URL mode
out6="$($GITPACK -r install "https://$URL.git=$OLD_VERSION")"
test "$out6" = ">>> running install for https://$URL.git=$OLD_VERSION
<<< done; successfully installed"

out7="$($GITPACK -r install "https://$URL.git")"
test "$out7" = ">>> running install for https://$URL.git
<<< done; successfully updated"

out8="$($GITPACK -r uninstall "https://$URL.git")"
test "$out8" = ">>> running uninstall for https://$URL.git
<<< done; successfully uninstalled"
