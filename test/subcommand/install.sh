#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# local installation
out1="$($GITPACK install "$URL")" &&
test -d "$HOME"/.local/bin/ &&
test -f "$HOME"/.local/bin/gitpack &&
test -x "$HOME"/.local/bin/gitpack &&
test -d "$HOME"/.bash_completion.d/ &&
test -f "$HOME"/.bash_completion.d/gitpack-completion &&
out2="$($GITPACK uninstall "$URL")" &&

# global installation
out3="$($SUDO_GITPACK install "$URL")" &&
sudo test -d /usr/local/bin/ &&
sudo test -f /usr/local/bin/gitpack &&
sudo test -x /usr/local/bin/gitpack &&
sudo test -d /etc/bash_completion.d/ &&
sudo test -f /etc/bash_completion.d/gitpack-completion &&
out4="$($SUDO_GITPACK uninstall "$URL")" &&

: "$out1" "$out2" "$out3" "$out4" # API already tested, no output check
