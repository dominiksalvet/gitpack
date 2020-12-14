#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# clean local cache
out1="$($GITPACK clean)" && # must succeed
test ! "$out1" && # must be empty

out2="$($GITPACK clean)" &&
test ! "$out2" &&

# clean global cache
out3="$($SUDO_GITPACK clean)" &&
test ! "$out3" &&

out4="$($SUDO_GITPACK clean)" &&
test ! "$out4" &&

# clean local state
test ! -s "$HOME"/.local/share/gitpack/status &&
rm "$HOME"/.local/share/gitpack/status &&
rmdir "$HOME"/.local/share/gitpack/ &&

# clean global state
sudo test ! -s /var/lib/gitpack/status &&
sudo rm /var/lib/gitpack/status &&
sudo rmdir /var/lib/gitpack/
