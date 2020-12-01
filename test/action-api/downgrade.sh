#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

gitpack_out="$($GITPACK install -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[install] $GITPACK_URL $GITPACK_VERSION" &&

gitpack_out="$($GITPACK status -o "$GITPACK_URL=$GITPACK_OLD_VERSION")" &&
test "$gitpack_out" = "[newer] $GITPACK_URL $GITPACK_VERSION -> $GITPACK_OLD_VERSION" &&

gitpack_out="$($GITPACK install -o "$GITPACK_URL=$GITPACK_OLD_VERSION")" &&
test "$gitpack_out" = "[downgrade] $GITPACK_URL $GITPACK_OLD_VERSION <- $GITPACK_VERSION" &&

gitpack_out="$($GITPACK uninstall -o "$GITPACK_URL")" &&
test "$gitpack_out" = "[uninstall] $GITPACK_URL $GITPACK_OLD_VERSION"
