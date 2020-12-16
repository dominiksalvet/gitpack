#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# work with two independent packages
out1="$($GITPACK install "$URL")" &&
test "$out1" = ">>> running install for $URL
<<< done; successfully installed" &&

out2="$($GITPACK install "$EXTRA_URL=$EXTRA_VERSION")" &&
test "$out2" = ">>> running install for $EXTRA_URL=$EXTRA_VERSION
<<< done; successfully installed" &&

out3="$($GITPACK status "$URL")" &&
test "$out3" = ">>> running status for $URL
<<< candidate $VERSION already installed" &&

out4="$($GITPACK status "$EXTRA_URL=$EXTRA_VERSION")" &&
test "$out4" = ">>> running status for $EXTRA_URL=$EXTRA_VERSION
<<< candidate $EXTRA_VERSION already installed" &&

out5="$($GITPACK uninstall "$URL")" &&
test "$out5" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

out6="$($GITPACK uninstall "$EXTRA_URL")" &&
test "$out6" = ">>> running uninstall for $EXTRA_URL
<<< done; successfully uninstalled"
