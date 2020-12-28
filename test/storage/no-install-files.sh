#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

test ! -e "$HOME/.local/bin/gitpack"
test ! -e "$HOME/.bash_completion.d/gitpack-completion"

if [ "$USE_SUDO" = true ]; then
    sudo test ! -e /usr/local/bin/gitpack
    sudo test ! -e /etc/bash_completion.d/gitpack-completion
fi
