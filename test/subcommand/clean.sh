#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

out1="$($GITPACK clean)" # it must delete cache
test ! -e "$LOCAL_CACHE_DIR"

out2="$($SUDO_GITPACK clean)"
test ! -e "$GLOBAL_CACHE_DIR"
