#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Checks whether GitPack source code files meet a defined code style using a
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
check_code_style() { (
    init_code_style && # initialize the code style check

    # perform checks for each given script file
    for script_path in "$@"; do
        check_line_length "$script_path" "$MAX_LINE_LENGTH" &&
        check_func_length "$script_path" "$MAX_FUNC_LENGTH" || return
    done
) }

# DESCRIPTION:
#   Initializes constants for code style check.
init_code_style() {
    MAX_LINE_LENGTH=80 # maximum number of characters per each line
    MAX_FUNC_LENGTH=20 # maximum number of lines per each function
    IGNORED_FUNCS='init_constants init_strings' # function length exceptions

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
}

# DESCRIPTION:
#   Checks whether each line of a given script file has at most a given number
#   of characters.
# PARAMETERS:
#   $1 - script path
#   $2 - maximum characters per line
check_line_length() {
    lineno=0 # initialize line counter
    while IFS= read -r line; do
        lineno="$((lineno + 1))" # increment line counter
        if [ "${#line}" -gt "$2" ]; then # check line length
            echo "$1:$lineno line has more than $2 characters" >&2
            return 1
        fi
    done < "$1"
}

# DESCRIPTION:
#   Checks whether each function of a given script file has at most a given
#   number of lines considering defined constants.
# PARAMETERS:
#   $1 - script path
#   $2 - maximum lines per function
check_func_length() {
    # use '(' as a field separator to make creating the final output easier
    awk_out="$(awk -F '(' "$FUNC_SUMMARY" "$1")" &&
    echo "$awk_out" | while read -r line; do # for each function summary
        lineno="$(echo "$line" | cut -f 1 -d ' ')" && # extract line number
        function="$(echo "$line" | cut -f 2 -d ' ')" && # extract function name
        lines="$(echo "$line" | cut -f 3 -d ' ')" || return # extract function length in lines

        for ignored_function in $IGNORED_FUNCS; do # exclude ignored functions
            if [ "$function" = "$ignored_function" ]; then
                lines="$2"
            fi
        done

        if [ "$lines" -gt "$2" ]; then # check function length
            echo "$1:$lineno $function() has more than $2 lines" >&2
            return 1
        fi
    done
}

#-------------------------------------------------------------------------------
# ANALYZE
#-------------------------------------------------------------------------------

shellcheck .ci/*.sh && # analyze CI scripts
shellcheck src/* && # analyze source code
check_code_style src/* && # check source code style
shellcheck .gitpack/data/.bash_completion .gitpack/install/local/precp # analyze other scripts
