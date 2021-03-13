#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# local paths
user_id="$(id -u)"
out1="$($GITPACK paths)"
test "$out1" = "state-dir $LOCAL_STATE_DIR
cache-dir $LOCAL_CACHE_DIR
lock-path $LOCK_DIR/gitpack-$user_id"

if [ "$USE_SUDO" = true ]; then
    # global paths
    root_id="$(sudo id -u)"
    out2="$($SUDO_GITPACK paths)"
    test "$out2" = "state-dir $GLOBAL_STATE_DIR
cache-dir $GLOBAL_CACHE_DIR
lock-path $LOCK_DIR/gitpack-$root_id"
fi
