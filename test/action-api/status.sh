#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020-2021 Dominik Salvet
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

out6="$($GITPACK -n status "$URL")"
test "$out6" = ">>> running status for $URL
<<< not installed; candidate is $VERSION"

out7="$($GITPACK -h status "$URL")"
test "$out7" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_SHORT_HASH"

out8="$($GITPACK -H status "$URL")"
test "$out8" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_HASH"

out9="$($GITPACK -r status "https://$URL.git")" # raw URL mode
test "$out9" = ">>> running status for https://$URL.git
<<< not installed; candidate is $VERSION"

out10="$(GITPACK_SKIP_LOCK=true $GITPACK status "$URL")"
test "$out10" = ">>> running status for $URL
<<< not installed; candidate is $VERSION"

# multiple options
out11="$($GITPACK -fh status "$URL")"
test "$out11" = ">>> running status for $URL
<<< not installed; candidate is $VERSION_SHORT_HASH"

out12="$($GITPACK -nS status "$URL")"
test "$out12" = ">>> running status for $URL
<<< not installed; candidate is $VERSION"

out13="$($GITPACK -Hr status "https://$URL.git")"
test "$out13" = ">>> running status for https://$URL.git
<<< not installed; candidate is $VERSION_HASH"

out14="$($GITPACK -hnr status "https://$URL.git")"
test "$out14" = ">>> running status for https://$URL.git
<<< not installed; candidate is $VERSION_SHORT_HASH"
