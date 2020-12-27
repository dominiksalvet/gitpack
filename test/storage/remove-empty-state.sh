#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

test -e "$LOCAL_STATE_DIR/status" # must exist
test ! -s "$LOCAL_STATE_DIR/status" # must be empty
rm "$LOCAL_STATE_DIR/status"
rmdir "$LOCAL_STATE_DIR/"

sudo test -e "$GLOBAL_STATE_DIR/status"
sudo test ! -s "$GLOBAL_STATE_DIR/status"
sudo rm "$GLOBAL_STATE_DIR/status"
sudo rmdir "$GLOBAL_STATE_DIR/"
