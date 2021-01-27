#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020-2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------


rm -f "$LOCAL_STATE_DIR/status"
if [ -d "$LOCAL_STATE_DIR/" ]; then
    rmdir "$LOCAL_STATE_DIR/"
fi

if [ "$USE_SUDO" = true ]; then
    sudo rm -f "$GLOBAL_STATE_DIR/status"
    if sudo [ -d "$GLOBAL_STATE_DIR/" ]; then
        sudo rmdir "$GLOBAL_STATE_DIR/"
    fi
fi
