#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020-2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

# local installation
out1="$($GITPACK install "$URL=$OLD_VERSION")" # API already tested
test -d "$HOME/.local/bin/"
test -f "$HOME/.local/bin/gitpack"
test -x "$HOME/.local/bin/gitpack"
test -d "$HOME/.bash_completion.d/"
test -f "$HOME/.bash_completion.d/gitpack-completion"
out2="$(cat "$LOCAL_STATE_DIR/status")"
test "$out2" = "$URL $OLD_VERSION_HASH"
out3="$($GITPACK uninstall "$URL")"

if [ "$USE_SUDO" = true ]; then
    # global installation
    out4="$($SUDO_GITPACK install "$URL=$OLD_VERSION")"
    sudo test -d /usr/local/bin/
    sudo test -f /usr/local/bin/gitpack
    sudo test -x /usr/local/bin/gitpack
    sudo test -d /etc/bash_completion.d/
    sudo test -f /etc/bash_completion.d/gitpack-completion
    out5="$(sudo cat "$GLOBAL_STATE_DIR/status")"
    test "$out5" = "$URL $OLD_VERSION_HASH"
    out6="$($SUDO_GITPACK uninstall "$URL")"
fi
