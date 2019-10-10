#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Runs the GitPack tester and if it is successful, checks its output for
#   potentially ignored error messages. The current state of execution is
#   reported to stderr.
#-------------------------------------------------------------------------------

# run all tests and store their exit status and output for further analysis
{   .ci/tester.sh 2>&1 1>/dev/null
    echo "$?" > ~/gitpack-tester-status 2>/dev/null # store exit status
} | tee ~/gitpack-tester-output >&2 && # store output

if ! tester_status="$(cat ~/gitpack-tester-status)"; then # load exit status
    echo 'cannot get exit status of tests' >&2; exit 1
fi &&

if [ "$tester_status" -eq 0 ]; then # if tests were successful, watch output
    # check if there is an error message (ignoring a diagnostic message format)
    echo testtest1 >&2 && while read -r line; do
        # if it does not match the diagnostic format, it is an error message
        if ! echo "$line" | grep -q '^[[:alpha:]]\+[[:digit:]]\+$'; then
            echo "error detected: $line" >&2; exit 1
        fi
    done < ~/gitpack-tester-output &&
    exit 0 # success
else
    exit "$tester_status" # fail
fi
