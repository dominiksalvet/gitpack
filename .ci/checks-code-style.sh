#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks whether the GitPack source code meets a defined code style.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# DEFINITIONS
#-------------------------------------------------------------------------------

MAX_LINE_LENGTH=80 # maximum number of characters per each line
MAX_FUNCTION_LENGTH=20 # maximum number of lines per each function
IGNORED_FUNCTIONS='init_constants init_strings' # function length exceptions

# AWK prints '<lineno> <function> <lines>' per line for shell script file inputs
# shellcheck disable=SC2016
FUNC_SUMMARY='{ if (/\(\)/) {
    printf NR" "$1" "
    lines=1
} else if (/^(\) )?\}$/) {
    print lines
} else {
    lines++
} }'

#-------------------------------------------------------------------------------
# LINE LENGTH
#-------------------------------------------------------------------------------

# DESCRIPTION:
#   Tests whether each line of a given file has at most a defined number of
#   characters.
# PARAMETERS:
#   $1 - file path
test_line_lenght() {
    lineno=0 # initialize line counter
    while IFS= read -r line; do
        lineno=$((lineno + 1)) # increment line counter
        if [ "${#line}" -gt "$MAX_LINE_LENGTH" ]; then # check line length
            echo "$1:$lineno line has more than $MAX_LINE_LENGTH characters" >&2
            return 1
        fi
    done < "$1"
}

#-------------------------------------------------------------------------------
# FUNCTION LENGTH
#-------------------------------------------------------------------------------

# DESCRIPTION:
#   Tests whether each function of a given script file has at most a defined
#   number of lines.
# PARAMETERS:
#   $1 - script path
test_func_lenght() {
    # use '(' as a field separator to make creating the final output easier
    awk_out="$(awk -F '(' "$FUNC_SUMMARY" "$1")" &&
    echo "$awk_out" | while read -r line; do # for each function summary
        lineno="$(echo "$line" | cut -f 1 -d ' ')" && # extract line number
        function="$(echo "$line" | cut -f 2 -d ' ')" && # extract function name
        lines="$(echo "$line" | cut -f 3 -d ' ')" || return # extract function length in lines

        for ignored_function in $IGNORED_FUNCTIONS; do # exclude ignored functions
            if [ "$function" = "$ignored_function" ]; then
                lines="$MAX_FUNCTION_LENGTH"
            fi
        done

        if [ "$lines" -gt "$MAX_FUNCTION_LENGTH" ]; then # check function length
            echo "$1:$lineno $function() has more than $MAX_FUNCTION_LENGTH lines" >&2
            return 1
        fi
    done
}

#-------------------------------------------------------------------------------
# TESTING
#-------------------------------------------------------------------------------

echo test1 >&2 && test_line_lenght src/gitpack &&
echo test2 >&2 && test_func_lenght src/gitpack &&
echo test3 >&2 && test_line_lenght src/gitpack-completion.bash &&
echo test4 >&2 && test_func_lenght src/gitpack-completion.bash
