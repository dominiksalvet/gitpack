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
        check_funcs_length "$script_path" || return
    done
)

# DESCRIPTION:
#   Initializes constants for code style check.
init_code_style() {
    readonly MAX_LINE_LENGTH=80 # maximum number of characters per each line
    readonly MAX_FUNC_LENGTH=20 # maximum number of lines per each function
    readonly IGNORED_FUNCS='init_constants init_strings' # function length exceptions
}

#-------------------------------------------------------------------------------
# LINES LENGTH
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
# FUNCTIONS LENGTH
#-------------------------------------------------------------------------------

# DESCRIPTION:
#   Checks whether each function of a given script file has at most a defined
#   number of lines.
# PARAMETERS:
#   $1 - script path
check_funcs_length() (
    # create function summaries '<lineno> <function> <lines>' and process them
    funcs_summary="$(get_funcs_summary "$1")" &&
    echo "$funcs_summary" | while IFS= read -r line; do # for each function summary
        lineno="$(echo "$line" | cut -f 1 -d ' ')" && # extract line number
        function="$(echo "$line" | cut -f 2 -d ' ')" && # extract function name
        lines="$(echo "$line" | cut -f 3 -d ' ')" || return # extract function length in lines

        # exclude ignored functions
        for ignored_function in $IGNORED_FUNCS; do
            if [ "$function" = "$ignored_function" ]; then lines="$MAX_FUNC_LENGTH"; fi
        done

        if [ "$lines" -gt "$MAX_FUNC_LENGTH" ]; then # check function length
            echo "$1:$lineno $function() has more than $MAX_FUNC_LENGTH lines" >&2; return 1
        fi
    done
)

# DESCRIPTION:
#   Prints a summary for each function in a given script. Each output line has
#   the following format: '<lineno> <function> <lines>'.
# PARAMETERS:
#   $1 - script path
get_funcs_summary() (
    lineno=0 # line counter
    function_lineno=; function_name= # function details
    in_function=false # indicator whether the parses is in a function

    while IFS= read -r line; do # for each line of the given script file
        lineno="$((lineno + 1))" && # increase line counter
        if [ "$in_function" = false ]; then
            if echo "$line" | grep -q '^[^#]*()'; then # check if function
                function_lineno="$lineno"
                function_name="${line%%(*}" # store its name
                in_function=true
            fi
        elif [ "$line" = '}' ] || [ "$line" = ')' ]; then # if end of function
            echo "$function_lineno $function_name $((lineno - function_lineno))"
            in_function=false
        fi || return
    done < "$1"
)

#-------------------------------------------------------------------------------
# ANALYZE
#-------------------------------------------------------------------------------

shellcheck .ci/*.sh && # analyze CI scripts
shellcheck src/* && # analyze source code
check_code_style src/* && # check source code style
shellcheck .gitpack/data/.bash_completion .gitpack/install/local/precp # analyze other scripts
