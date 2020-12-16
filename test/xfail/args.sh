#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$(! $GITPACK)" &&
out2="$(! $GITPACK -h)" &&
out3="$(! $GITPACK duck)" &&
out4="$(! $GITPACK statuss)" &&
out5="$(! $GITPACK "$URL")" &&
out6="$(! $GITPACK status)" &&
out7="$(! $GITPACK -h status)" &&
out8="$(! $GITPACK -z status "$URL")" &&

: "$out1" "$out2" "$out3" "$out4" "$out5" "$out6" "$out7" "$out8"
