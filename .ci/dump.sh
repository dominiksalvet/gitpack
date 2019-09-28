#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Dumps useful GitPack data stored on the disk. Prefers the local installation
#   data to the global installation data.
#-------------------------------------------------------------------------------

# dump the preferred log
if [ -r ~/.local/share/gitpack/gitpack.log ]; then
    cat ~/.local/share/gitpack/gitpack.log
elif [ -r /var/log/gitpack/gitpack.log ]; then
    cat /var/log/gitpack/gitpack.log
fi
