#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks whether the main GitPack script meets a basic code style.
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

lineno=0 # initialize line counter
# shellcheck disable=SC2016
while IFS= read -r line; do
    lineno=$((lineno + 1)) # increment line counter
    if [ "${#line}" -gt "$MAX_LINE_LENGTH" ]; then # check line length
        echo "src/gitpack:$lineno line has more than $MAX_LINE_LENGTH characters" >&2
        return 1
    fi
done < src/gitpack &&

#-------------------------------------------------------------------------------
# FUNCTION LENGTH
#-------------------------------------------------------------------------------

# transforms a given shell script into '<function> <lines>' per line output
AWK_PROGRAM='{ if (/\(\)/) {
    printf NR" "$1" "
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
    lineno="$(echo "$line" | cut -f 1 -d ' ')" && # extract line number
    function="$(echo "$line" | cut -f 2 -d ' ')" && # extract function name
    lines="$(echo "$line" | cut -f 3 -d ' ')" || return # extract function length in lines

    for ignored_function in $IGNORED_FUNCTIONS; do # exclude ignored functions
        if [ "$function" = "$ignored_function" ]; then
            lines="$MAX_FUNCTION_LENGTH"
        fi
    done

    if [ "$lines" -gt "$MAX_FUNCTION_LENGTH" ]; then # check function length
        echo "src/gitpack:$lineno $function() has more than $MAX_FUNCTION_LENGTH lines" >&2
        return 1
    fi
done
