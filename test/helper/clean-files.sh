#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020-2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# $1 - directory
rm_empty_dir() {
    if [ -d "$1/" ]; then
        rmdir "$1/"
    fi
}

# $1 - directory
sudo_rm_empty_dir() {
    if sudo [ -d "$1/" ]; then
        sudo rmdir "$1/"
    fi
}

# clean state
rm -f "$LOCAL_STATE_DIR/status"
rm_empty_dir "$LOCAL_STATE_DIR"

# clean cache
rm -f "$LOCAL_CACHE_DIR/fetched"
rm -rf "$LOCAL_CACHE_DIR/repos/"
rm_empty_dir "$LOCAL_CACHE_DIR"

# clean installed
rm -f "$HOME/.local/bin/gitpack"
rm -f "$HOME/.bash_completion.d/gitpack-completion"

if [ "$USE_SUDO" = true ]; then
    # clean state
    sudo rm -f "$GLOBAL_STATE_DIR/status"
    sudo_rm_empty_dir "$GLOBAL_STATE_DIR"

    # clean cache
    sudo rm -f "$GLOBAL_CACHE_DIR/fetched"
    sudo rm -rf "$GLOBAL_CACHE_DIR/repos/"
    sudo_rm_empty_dir "$GLOBAL_CACHE_DIR"

    # clean installed
    sudo rm -f /usr/local/bin/gitpack
    sudo rm -f /etc/bash_completion.d/gitpack-completion
fi
