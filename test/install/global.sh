#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($SUDO_GITPACK -H install "$URL=$HASH")" &&
test "$out1" = ">>> running install for $URL=$HASH
<<< done; successfully installed" &&

out2="$($SUDO_GITPACK -H status "$URL=$HASH")" &&
test "$out2" = ">>> running status for $URL=$HASH
<<< candidate $HASH already installed" &&

out3="$($SUDO_GITPACK -H uninstall "$URL")" &&
test "$out3" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"
