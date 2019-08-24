#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# SPDX-License-Identifier: MIT
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# check whether all lines have at most 80 characters
while read -r line; do
    test "${#line}" -le 80 || exit
done < src/gitpack
