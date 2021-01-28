#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

out1="$($GITPACK install "$URL")"
out2="$(! $GITPACK -r status "https://$URL.git")"
out3="$($GITPACK -rd status "https://$URL.git")"
out4="$($GITPACK uninstall "$URL")"

out5="$($GITPACK -r install "https://$URL.git")"
out6="$(! $GITPACK status "$URL")"
out7="$($GITPACK -d status "$URL")"
out8="$($GITPACK -r uninstall "https://$URL.git")"

out9="$($GITPACK install "$URL")"
out10="$($GITPACK install "$EXTRA_URL")"
out11="$(! $GITPACK -r status "https://$URL.git")"
out12="$(! $GITPACK -r status "https://$EXTRA_URL.git")"
out13="$($GITPACK -rd status "https://$URL.git")"
out14="$($GITPACK -rd status "https://$EXTRA_URL.git")"
out15="$($GITPACK uninstall "$URL")"
out16="$($GITPACK uninstall "$EXTRA_URL")"
