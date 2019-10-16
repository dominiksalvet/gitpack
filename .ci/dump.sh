#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Dumps useful GitPack data stored on the disk. Prefers the local installation
#   data to the global installation data.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# DEFINITIONS
#-------------------------------------------------------------------------------

readonly GLOBAL_LOG_PATH=/var/log/gitpack/gitpack.log
readonly LOCAL_LOG_PATH="$HOME"/.local/share/gitpack/gitpack.log

#-------------------------------------------------------------------------------
# PRINT LOG
#-------------------------------------------------------------------------------

# dump the preferred log
if [ -r "$LOCAL_LOG_PATH" ]; then # print local if exists
    cat "$LOCAL_LOG_PATH"
elif [ -r "$GLOBAL_LOG_PATH" ]; then # otherwise, print global
    cat "$GLOBAL_LOG_PATH"
fi
