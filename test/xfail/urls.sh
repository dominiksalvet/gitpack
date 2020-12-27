#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

out1="$(! $GITPACK status '')"
out2="$(! $GITPACK status ' ')"
out3="$(! $GITPACK status 'bad url')"
out4="$(! $GITPACK status 'bad
url')"

out5="$(! $GITPACK status .)"
out6="$(! $GITPACK status ..)"
out7="$(! $GITPACK status "$URL/.")"
out8="$(! $GITPACK status "$URL/..")"
out9="$(! $GITPACK status "./$URL")"
out10="$(! $GITPACK status "../$URL")"
out11="$(! $GITPACK status bad/./url)"
out12="$(! $GITPACK status bad/../url)"

out13="$(! $GITPACK status 'github.com/dominik
salvet/gitpack')"
out14="$(! $GITPACK status "$URL=nonexistent")"
