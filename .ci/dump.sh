#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Dumps useful GitPack data stored on the disk based on a given access level.
#   Exits with a given expected exit status to make error propagation possible.
# PARAMETERS:
#   $1 - access level
#   $2 - expected exit status
#-------------------------------------------------------------------------------

# dump the GitPack data
if [ "$1" = global ]; then
    cat /var/log/gitpack/gitpack.log
    cat /var/lib/gitpack/status
else
    cat "$HOME"/.local/share/gitpack/gitpack.log
    cat "$HOME"/.local/share/gitpack/status
fi

return "$2" # return the expected exit status
