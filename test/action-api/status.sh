#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($GITPACK status "$URL")"
test "$out1" = ">>> running status for $URL
<<< not installed; candidate is $VERSION"

out2="$($GITPACK status "$URL")" # must not change
test "$out2" = ">>> running status for $URL
<<< not installed; candidate is $VERSION"

out3="$($GITPACK status "$URL=$VERSION")"
test "$out3" = ">>> running status for $URL=$VERSION
<<< not installed; candidate is $VERSION"

out4="$($GITPACK status "$URL=$VERSION_HASH")"
test "$out4" = ">>> running status for $URL=$VERSION_HASH
<<< not installed; candidate is $VERSION"

# single options
out5="$($GITPACK -f status "$URL")"
test "$out5" = ">>> running status for $URL
<<< not installed; candidate is $VERSION"

out6="$($GITPACK -h status "$URL")"
test "$out6" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_SHORT_HASH"

out7="$($GITPACK -H status "$URL")"
test "$out7" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_HASH"

out8="$($GITPACK -r status "https://$URL.git")" # raw URL mode
test "$out8" = ">>> running status for https://$URL.git
<<< not installed; candidate is $VERSION"

# multiple options
out9="$($GITPACK -fh status "$URL")"
test "$out9" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_SHORT_HASH"

out10="$($GITPACK -Hr status "https://$URL.git")"
test "$out10" = ">>> running status for https://$URL.git
<<< not installed; candidate is $VERSION_HASH"
