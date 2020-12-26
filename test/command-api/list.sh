#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

out1="$($GITPACK list)" # must succeed
test ! "$out1" # must be empty

# single package
out2="$($GITPACK install "$URL")"
test "$out2" = ">>> running install for $URL
<<< done; successfully installed"

out3="$($GITPACK list)"
test "$out3" = "$URL $VERSION"

out4="$($GITPACK -h list)"
test "$out4" = "$URL $VERSION_SHORT_HASH"

out5="$($GITPACK -H list)"
test "$out5" = "$URL $VERSION_HASH"

# two packages
out6="$($GITPACK install "$EXTRA_URL=$EXTRA_VERSION")"
test "$out6" = ">>> running install for $EXTRA_URL=$EXTRA_VERSION
<<< done; successfully installed"

out7="$($GITPACK list)"
test "$out7" = "$URL $VERSION
$EXTRA_URL $EXTRA_VERSION"

out8="$($GITPACK uninstall "$URL")"
test "$out8" = ">>> running uninstall for $URL
<<< done; successfully uninstalled"

# single package again
out9="$($GITPACK list)"
test "$out9" = "$EXTRA_URL $EXTRA_VERSION"

out10="$($GITPACK uninstall "$EXTRA_URL")"
test "$out10" = ">>> running uninstall for $EXTRA_URL
<<< done; successfully uninstalled"

out11="$($GITPACK list)"
test ! "$out11" # empty again
