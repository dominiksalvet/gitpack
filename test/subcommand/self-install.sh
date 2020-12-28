#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# local self-install
out1="$($GITPACK -H install "$URL=$HASH")"
test "$out1" = ">>> running install for $URL=$HASH
<<< done; successfully installed"

out2="$(sh -x "$HOME/.local/bin/gitpack" -H status "$URL=$HASH")"
test "$out2" = ">>> running status for $URL=$HASH
<<< candidate $HASH already installed"

out3="$(sh -x "$HOME/.local/bin/gitpack" -H uninstall "$URL")"
test "$out3" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"

# global self-install
out4="$($SUDO_GITPACK -H install "$URL=$HASH")"
test "$out4" = ">>> running install for $URL=$HASH
<<< done; successfully installed"

out5="$(sudo sh -x /usr/local/bin/gitpack -H status "$URL=$HASH")"
test "$out5" = ">>> running status for $URL=$HASH
<<< candidate $HASH already installed"

out6="$(sudo sh -x /usr/local/bin/gitpack -H uninstall "$URL")"
test "$out6" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"
