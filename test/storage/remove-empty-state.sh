#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

test -e "$HOME"/.local/share/gitpack/status # must exist
test ! -s "$HOME"/.local/share/gitpack/status # must be empty
rm "$HOME"/.local/share/gitpack/status
rmdir "$HOME"/.local/share/gitpack/

sudo test -e /var/lib/gitpack/status
sudo test ! -s /var/lib/gitpack/status
sudo rm /var/lib/gitpack/status
sudo rmdir /var/lib/gitpack/
