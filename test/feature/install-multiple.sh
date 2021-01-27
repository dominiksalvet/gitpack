#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020-2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# install first package
out1="$($GITPACK install "$URL=$VERSION")"
test "$out1" = ">>> running install for $URL=$VERSION
<<< done; successfully installed"

out2="$(cut "$LOCAL_STATE_DIR/status")"
test "$out2" = "$URL $VERSION_HASH"

# install second package
out3="$($GITPACK install "$EXTRA_URL=$EXTRA_VERSION")"
test "$out3" = ">>> running install for $EXTRA_URL=$EXTRA_VERSION
<<< done; successfully installed"

out4="$(cut "$LOCAL_STATE_DIR/status")"
test "$out4" = "$URL $VERSION_HASH
$EXTRA_URL $EXTRA_VERSION_HASH"

# check status
out5="$($GITPACK status "$URL=$VERSION")"
test "$out5" = ">>> running status for $URL=$VERSION
<<< candidate $VERSION already installed"

out6="$($GITPACK status "$EXTRA_URL=$EXTRA_VERSION")"
test "$out6" = ">>> running status for $EXTRA_URL=$EXTRA_VERSION
<<< candidate $EXTRA_VERSION already installed"

# uninstall first package
out7="$($GITPACK uninstall "$URL=$VERSION")"
test "$out7" = ">>> running uninstall for $URL=$VERSION
<<< done; successfully uninstalled"

out8="$(cut "$LOCAL_STATE_DIR/status")"
test "$out8" = "$EXTRA_URL $EXTRA_VERSION_HASH"

# uninstall second package
out9="$($GITPACK uninstall "$EXTRA_URL")"
test "$out9" = ">>> running uninstall for $EXTRA_URL
<<< done; successfully uninstalled"

out10="$(cut "$LOCAL_STATE_DIR/status")"
test ! "$out10"
