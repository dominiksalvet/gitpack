#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out="$($GITPACK status "$URL")" &&
test "$out" = ">>> running status for $URL
<<< not installed; candidate is $VERSION" &&

out="$($GITPACK status "$URL")" && # must not change
test "$out" = ">>> running status for $URL
<<< not installed; candidate is $VERSION" &&

out="$($GITPACK status "$URL=$VERSION")" &&
test "$out" = ">>> running status for $URL=$VERSION
<<< not installed; candidate is $VERSION" &&

out="$($GITPACK status "$URL=$VERSION_HASH")" &&
test "$out" = ">>> running status for $URL=$VERSION_HASH
<<< not installed; candidate is $VERSION" &&

# single options
out="$($GITPACK -f status "$URL")" &&
test "$out" = ">>> running status for $URL
<<< not installed; candidate is $VERSION" &&

out="$($GITPACK -h status "$URL")" &&
test "$out" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_SHORT_HASH" &&

out="$($GITPACK -H status "$URL")" &&
test "$out" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_HASH" &&

out="$($GITPACK -r status "https://$URL.git")" && # raw URL mode
test "$out" = ">>> running status for https://$URL.git
<<< not installed; candidate is $VERSION" &&

# multiple options
out="$($GITPACK -fh status "$URL")" &&
test "$out" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_SHORT_HASH" &&

out="$($GITPACK -Hr status "https://$URL.git")" &&
test "$out" = ">>> running status for https://$URL.git
<<< not installed; candidate is $VERSION_HASH"
