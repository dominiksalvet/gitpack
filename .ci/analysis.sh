#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Checks whether GitPack source code files meet essential code style using a
#   static code analysis.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# CODE STYLE
#-------------------------------------------------------------------------------

# DESCRIPTION:
#   Checks the code style of all given scripts against simple predefined rules.
#   Runs in a subshell to imitate an external command.
# PARAMETERS:
#   $@ - script paths
check_code_style() (
    init_code_style && # initialize the code style check

    # perform checks for each given script file
    for script_path in "$@"; do
        check_lines_length "$script_path" &&
        check_functions "$script_path" || return
    done
)

# DESCRIPTION:
#   Initializes constants for code style check.
init_code_style() {
    readonly MAX_LINE_LENGTH=80 # maximum number of characters per each line
    readonly MAX_FUNC_LENGTH=20 # maximum number of lines per each function
    readonly IGNORED_FUNCS='init_constants init_strings' # function length exceptions

    # AWK prints '<lineno> <function> <lines>' per line for shell script file inputs
    # shellcheck disable=SC2016
    readonly FUNC_SUMMARY='{ if (/\(\)/) {
        printf NR" "$1" "
        lines=1
    } else if (/^(\}|\))$/) {
        print lines
    } else {
        lines++
    } }'
}

#-------------------------------------------------------------------------------
# LINES LENGHT
#-------------------------------------------------------------------------------

# DESCRIPTION:
#   Checks whether each line of a given script file has at most a defined number
#   of characters.
# PARAMETERS:
#   $1 - script path
check_lines_length() (
    lineno=0 # initialize line counter
    while IFS= read -r line; do
        lineno="$((lineno + 1))" # increment line counter
        if [ "${#line}" -gt "$MAX_LINE_LENGTH" ]; then # check line length
            echo "$1:$lineno line has more than $MAX_LINE_LENGTH characters" >&2; return 1
        fi
    done < "$1"
)

#-------------------------------------------------------------------------------
# CHECK FUNCTIONS
#-------------------------------------------------------------------------------

# DESCRIPTION:
#   Checks whether each function of a given script file meets code style.
# PARAMETERS:
#   $1 - script path
check_functions() (
    prev_lineno=; prev_function= # initialize previous function details
    # use '(' as a field separator to make creating the final output easier
    awk_out="$(awk -F '(' "$FUNC_SUMMARY" "$1")" &&
    echo "$awk_out" | while IFS= read -r line; do # for each function summary
        lineno="$(echo "$line" | cut -f 1 -d ' ' -s)" && # extract line number
        function="$(echo "$line" | cut -f 2 -d ' ' -s)" && # extract function name
        lines="$(echo "$line" | cut -f 3 -d ' ' -s)" || return # extract function length in lines

        if [ ! "$lineno" ] || [ ! "$function" ] || [ ! "$lines" ]; then
            echo "$1:$prev_lineno $prev_function() has bad code style" >&2; return 1
        fi

        if ! check_function_length "$function" "$lines" "$MAX_FUNC_LENGTH"; then
            echo "$1:$lineno $function() has more than $MAX_FUNC_LENGTH lines" >&2; return 1
        fi

        prev_lineno="$lineno"; prev_function="$function" # store previous function details
    done
)

# DESCRIPTION:
#   Checks whether a given function with a given number of lines has at most a
#   given maximum number of lines considering ignored functions.
# PARAMETERS:
#   $1 - function name
#   $2 - function lines
#   #3 - maximum lines
check_function_length() (
    lines="$2" # store number of lines in the function

    # exclude ignored functions
    for ignored_function in $IGNORED_FUNCS; do
        if [ "$1" = "$ignored_function" ]; then lines="$3"; fi
    done

    # function lines must be less or equal to maximum lines
    test "$lines" -le "$3"
)

#-------------------------------------------------------------------------------
# ANALYZE
#-------------------------------------------------------------------------------

shellcheck .ci/*.sh && # analyze CI scripts
shellcheck src/* && # analyze source code
check_code_style src/* && # check source code style
shellcheck .gitpack/data/.bash_completion .gitpack/install/local/precp # analyze other scripts
