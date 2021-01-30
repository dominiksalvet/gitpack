#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020-2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

# local uninstallation
out1="$($GITPACK install "$URL=$OLD_VERSION")"
out2="$($GITPACK uninstall "$URL")"
test ! -e "$HOME/.local/bin/gitpack"
test ! -e "$HOME/.bash_completion.d/gitpack-completion"
out3="$(cat "$LOCAL_STATE_DIR/status")"
test ! "$out3"

if [ "$USE_SUDO" = true ]; then
    # global uninstallation
    out4="$($SUDO_GITPACK install "$URL=$OLD_VERSION")"
    out5="$($SUDO_GITPACK uninstall "$URL")"
    sudo test ! -e /usr/local/bin/gitpack
    sudo test ! -e /etc/bash_completion.d/gitpack-completion
    out6="$(sudo cat "$GLOBAL_STATE_DIR/status")"
    test ! "$out6"
fi
