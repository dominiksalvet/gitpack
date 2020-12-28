#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

# local uninstallation
out1="$($GITPACK install "$URL=$OLD_VERSION")"
out2="$($GITPACK uninstall "$URL")"
test ! -e "$HOME/.local/bin/gitpack"
test ! -e "$HOME/.bash_completion.d/gitpack-completion"

if [ "$USE_SUDO" = true ]; then
    # global uninstallation
    out3="$($SUDO_GITPACK install "$URL=$OLD_VERSION")"
    out4="$($SUDO_GITPACK uninstall "$URL")"
    sudo test ! -e /usr/local/bin/gitpack
    sudo test ! -e /etc/bash_completion.d/gitpack-completion
fi
