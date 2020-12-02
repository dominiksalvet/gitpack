#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out="$($GITPACK help)" && # must succeed
test "$out" && # must not be empty

out="$($GITPACK about)" &&
test "$out"
