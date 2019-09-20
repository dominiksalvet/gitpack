#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
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
    cat /var/log/gitpack/gitpack.log >&2
    cat /var/lib/gitpack/status >&2
else
    cat ~/.local/share/gitpack/gitpack.log >&2
    cat ~/.local/share/gitpack/status >&2
fi

exit "$2" # exit with the expected exit status
