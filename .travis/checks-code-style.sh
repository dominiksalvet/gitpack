#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# CONFIGURATION
#-------------------------------------------------------------------------------

MAX_LINE_LENGTH=80 # maximum number of characters per each line
MAX_FUNCTION_LENGTH=20 # maximum number of lines per each function
IGNORED_FUNCTIONS='init_constants init_strings' # function length exceptions

#-------------------------------------------------------------------------------
# LINE LENGTH
#-------------------------------------------------------------------------------

# shellcheck disable=SC2016
while read -r line; do
    if [ "${#line}" -gt "$MAX_LINE_LENGTH" ]; then # check line length
        echo "src/gitpack must have lines with $MAX_LINE_LENGTH characters at most" >&2
        return 1
    fi
done < src/gitpack &&

#-------------------------------------------------------------------------------
# FUNCTION LENGTH
#-------------------------------------------------------------------------------

# transforms a given shell script into '<function> <lines>' per line output
AWK_PROGRAM='{ if (/\(\)/) {
    printf $1" "
    lines=1
} else if (/^(\) )?\}$/) {
    print lines
} else {
    lines++
} }' &&

# use '(' as a field separator to make creating the final output easier
awk_out="$(awk -F '(' "$AWK_PROGRAM" src/gitpack)" &&
echo "$awk_out" |
while read -r line; do
    function="${line%% *}" # extract function name
    lines="${line##* }" # extract function length in lines

    for ignored_function in $IGNORED_FUNCTIONS; do # exclude ignored functions
        if [ "$function" = "$ignored_function" ]; then
            lines="$MAX_FUNCTION_LENGTH"
        fi
    done

    if [ "$lines" -gt "$MAX_FUNCTION_LENGTH" ]; then # check function length
        echo "src/gitpack must have functions with $MAX_FUNCTION_LENGTH lines at most" >&2
        return 1
    fi
done
