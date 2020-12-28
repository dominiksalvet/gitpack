#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# local before global (FIFO)
out1="$($GITPACK install "$URL")"
test "$out1" = ">>> running install for $URL
<<< done; successfully installed"

out2="$(su -c "$GITPACK install $URL")" # must not be already installed
test "$out2" = ">>> running install for $URL
<<< done; successfully installed"

out3="$($GITPACK uninstall "$URL")"
test "$out3" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"

out4="$($SUDO_GITPACK uninstall "$URL")" # must not be already uninstalled
test "$out4" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"

# global before local (LIFO)
out5="$($SUDO_GITPACK install "$URL")"
test "$out5" = ">>> running install for $URL
<<< done; successfully installed"

out6="$($GITPACK install "$URL")"
test "$out6" = ">>> running install for $URL
<<< done; successfully installed"

out7="$($GITPACK uninstall "$URL")"
test "$out7" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"

out8="$($SUDO_GITPACK uninstall "$URL")"
test "$out8" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"
