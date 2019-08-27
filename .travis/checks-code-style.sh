#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# check whether all lines have at most 80 characters
# shellcheck disable=SC2016
while read -r line; do
    test "${#line}" -le 80 || return
done < src/gitpack &&

# check whether all functions have at most 20 lines
IGNORED_FUNCTIONS='init_constants init_strings' &&
AWK_PROGRAM='{ if (/\(\)/) {
    printf $1" "
    lines=1
} else if (/^(\) )?\}$/) {
    print lines
} else {
    lines++
} }' &&

awk_out="$(awk -F '(' "$AWK_PROGRAM" src/gitpack)" &&
echo "$awk_out" |
while read -r line; do
    function="${line%% *}" &&
    lines="${line##* }" &&
    for ignored in $IGNORED_FUNCTIONS; do
        if [ "$function" = "$ignored" ]; then
            lines=20
        fi
    done &&
    test "$lines" -le 20 || return
done
