#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Dumps useful GitPack data stored on the disk. Prefers the local installation
#   data to the global installation data. Exits with a given expected exit
#   status to make error propagation easier.
# PARAMETERS:
#   $1 - expected exit status
#-------------------------------------------------------------------------------

# dump the preferred log
if [ -r ~/.local/share/gitpack/gitpack.log ]; then
    cat ~/.local/share/gitpack/gitpack.log >&2
elif [ -r /var/log/gitpack/gitpack.log ]; then
    cat /var/log/gitpack/gitpack.log >&2
fi

exit "$1" # exit with the expected exit status
