#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020-2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

out1="$(! $GITPACK)"
out2="$(! $GITPACK -h)"
out3="$(! $GITPACK duck)"
out4="$(! $GITPACK statuss)"
out5="$(! $GITPACK "$URL")"
out6="$(! $GITPACK status)"
out7="$(! $GITPACK -h status)"

out8="$(! $GITPACK -z list)"
out9="$(! $GITPACK -zz list)"
out10="$(! $GITPACK -hz list)"
out11="$(! $GITPACK -zh list)"
out12="$(! $GITPACK -hzH list)"
