#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($GITPACK help)" && # must succeed
test "$out1" && # must not be empty

out2="$($GITPACK about)" &&
test "$out2"
