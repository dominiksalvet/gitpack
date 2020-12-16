#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

out1="$(! $GITPACK)" &&
out2="$(! $GITPACK -h)" &&
out3="$(! $GITPACK duck)" &&
out4="$(! $GITPACK statuss)" &&
out5="$(! $GITPACK "$URL")" &&
out6="$(! $GITPACK status)" &&
out7="$(! $GITPACK -h status)" &&
out8="$(! $GITPACK -z status "$URL")"
