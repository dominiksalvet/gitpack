#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# local before global (FIFO)
out="$($GITPACK install "$URL")" &&
test "$out" = ">>> running install for $URL
<<< done; successfully installed" &&

out="$($SUDO_GITPACK install "$URL")" && # must not be already installed
test "$out" = ">>> running install for $URL
<<< done; successfully installed" &&

out="$($GITPACK uninstall "$URL")" &&
test "$out" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

out="$($SUDO_GITPACK uninstall "$URL")" && # must not be already uninstalled
test "$out" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

# global before local (LIFO)
out="$($SUDO_GITPACK install "$URL")" &&
test "$out" = ">>> running install for $URL
<<< done; successfully installed" &&

out="$($GITPACK install "$URL")" &&
test "$out" = ">>> running install for $URL
<<< done; successfully installed" &&

out="$($GITPACK uninstall "$URL")" &&
test "$out" = ">>> running uninstall for $URL
<<< done; successfully uninstalled" &&

out="$($SUDO_GITPACK uninstall "$URL")" &&
test "$out" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"
