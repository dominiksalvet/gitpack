#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

test ! -e "$HOME"/.local/bin/gitpack
test ! -e "$HOME"/.bash_completion.d/gitpack-completion

test ! -e /usr/local/bin/gitpack
test ! -e /etc/bash_completion.d/gitpack-completion
