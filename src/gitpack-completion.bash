#!/bin/bash

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This file implements a prompting tab completion for GitPack in Bash shells.
#   It works with all mandatory GitPack arguments. It is expected to be sourced.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# COMPLETION GENERATOR
#-------------------------------------------------------------------------------

# DESCRIPTION:
#   Prepares the next word hint based on the current part of the word.
_gitpack() {
    local FIRST_WORDS='install uninstall status list clean help about' &&
    local first_word="${COMP_WORDS[1]}" &&
    local cur_word="${COMP_WORDS[COMP_CWORD]}" && # the current part of the word

    if [ "$COMP_CWORD" -eq 1 ]; then # actions and commands
        # prepare hints based on given arguments
        mapfile -t COMPREPLY < <(compgen -W "$FIRST_WORDS" -- "$cur_word")
    else # repository URLs
        case "$first_word" in # print them only for actions
            install|uninstall|status) _gitpack_url ;;
        esac
    fi
}

# DESCRIPTION:
#   Prepares the next URL hint based on the current one.
_gitpack_url() {
    local cached_urls &&
    # collect global and local cached repository paths (URLs)
    cached_urls="$(
        cd /var/cache/gitpack/repo/ 2>/dev/null &&
        find ./ -maxdepth 3 -mindepth 3 -type d | sed 's|^./||'
        cd ~/.cache/gitpack/repo/ 2>/dev/null &&
        find ./ -maxdepth 3 -mindepth 3 -type d | sed 's|^./||'
        true
    )" &&
    # prepare hints based on given arguments
    mapfile -t COMPREPLY < <(compgen -W "$cached_urls" -- "$cur_word")
}

#-------------------------------------------------------------------------------
# APPLY COMPLETION
#-------------------------------------------------------------------------------

# register the gitpack completion to the current shell environment
complete -F _gitpack gitpack
