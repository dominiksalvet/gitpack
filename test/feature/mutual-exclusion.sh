#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2021 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

for i in 1 2 3 4 5; do # repeat multiple times
    # first GitPack instance
    {   set +e # ignore simple command fails in this subshell
        out1="$($GITPACK install "$URL=$VERSION")"
        echo "$?" > /tmp/gitpack-status-1
    } &

    # second GitPack instance
    {   set +e
        out2="$($GITPACK install "$EXTRA_URL=$EXTRA_VERSION")"
        echo "$?" > /tmp/gitpack-status-2
    } &

    wait # wait for both processes to finish

    status_1="$(cat /tmp/gitpack-status-1)"
    out3="$($GITPACK status "$URL=$VERSION")"
    if [ "$status_1" -eq 0 ]; then
        test "$out3" = ">>> running status for $URL=$VERSION
<<< candidate $VERSION already installed"
    elif [ "$status_1" -eq 64 ]; then
        test "$out3" = ">>> running status for $URL=$VERSION
<<< not installed; candidate is $VERSION"
    else
        false # no other exit statuses accepted
    fi

    status_2="$(cat /tmp/gitpack-status-2)"
    out4="$($GITPACK status "$EXTRA_URL=$EXTRA_VERSION")"
    if [ "$status_2" -eq 0 ]; then
        test "$out4" = ">>> running status for $EXTRA_URL=$EXTRA_VERSION
<<< candidate $EXTRA_VERSION already installed"
    elif [ "$status_2" -eq 64 ]; then
        test "$out4" = ">>> running status for $EXTRA_URL=$EXTRA_VERSION
<<< not installed; candidate is $EXTRA_VERSION"
        test "$status_1" -ne 64 # at least one must acquire lock
    else
        false
    fi

    out5="$($GITPACK uninstall "$URL")"
    out6="$($GITPACK uninstall "$EXTRA_URL")"
done
