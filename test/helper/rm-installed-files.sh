#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020-2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

rm -f "$HOME/.local/bin/gitpack"
rm -f "$HOME/.bash_completion.d/gitpack-completion"

if [ "$USE_SUDO" = true ]; then
    sudo rm -f /usr/local/bin/gitpack
    sudo rm -f /etc/bash_completion.d/gitpack-completion
fi
