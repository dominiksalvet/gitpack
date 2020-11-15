#!/bin/bash

#-------------------------------------------------------------------------------
# Copyright 2019-2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# This file represents a GitPack extension, which incorporates a prompting tab
# completion of GitPak arguments into Bash shells. It is expected to be sourced.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# COMPLETION GENERATOR
#-------------------------------------------------------------------------------

_gitpack() {
    # the list of possible first arguments
    local -r FIRST_WORDS='install uninstall status
                          list clean paths help about' &&
    local first_word="${COMP_WORDS[1]}" &&
    local cur_word="${COMP_WORDS[COMP_CWORD]}" && # the current part of the word

    if [ "$COMP_CWORD" -eq 1 ]; then # actions and commands
        # prepare hints based on given arguments
        mapfile -t COMPREPLY < <(compgen -W "$FIRST_WORDS" -- "$cur_word")
    else # repository URLs
        case "$first_word" in # print them only for actions
            install | uninstall | status) _gitpack_url ;;
        esac
    fi
}

_gitpack_url() {
    local fetched_urls &&
    # collect global and local fetched URLs
    fetched_urls="$(
        cut -f 1 -d ' ' /var/cache/gitpack/fetched 2>/dev/null
        cut -f 1 -d ' ' "$HOME"/.cache/gitpack/fetched 2>/dev/null
        true
    )" &&
    mapfile -t COMPREPLY < <(compgen -W "$fetched_urls" -- "$cur_word")
}

#-------------------------------------------------------------------------------
# APPLY COMPLETION
#-------------------------------------------------------------------------------

# register the gitpack completion to the current shell environment
complete -F _gitpack gitpack
