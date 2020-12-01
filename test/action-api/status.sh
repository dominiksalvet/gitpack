#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

gitpack_out="$($GITPACK status "$GITPACK_URL")" &&
test "$gitpack_out" = "[nothing] $GITPACK_URL -> $GITPACK_VERSION" &&

gitpack_out="$($GITPACK status -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[nothing] $GITPACK_URL -> $GITPACK_VERSION"
