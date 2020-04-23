#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

gitpack_out="$($GITPACK install -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[install] $GITPACK_URL $GITPACK_VERSION" &&
gitpack_out="$($GITPACK install -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[installed] $GITPACK_URL $GITPACK_VERSION" &&

gitpack_out="$($GITPACK status -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[ok] $GITPACK_URL $GITPACK_VERSION" &&

gitpack_out="$($GITPACK uninstall -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[uninstall] $GITPACK_URL $GITPACK_VERSION" &&
gitpack_out="$($GITPACK uninstall -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[uninstalled] $GITPACK_URL" &&

gitpack_out="$($GITPACK status -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[nothing] $GITPACK_URL -> $GITPACK_VERSION"
