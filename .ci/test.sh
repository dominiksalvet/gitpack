#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Runs GitPack tests and if they are successful, checks their output for
#   potentially ignored error messages. The current state of execution is
#   reported to stderr.
#-------------------------------------------------------------------------------

# run all tests and store their exit status and output for further analysis
{   .ci/tests.sh 2>&1 1>/dev/null
    echo "$?" > ~/gitpack-tests-status 2>/dev/null # store exit status
} | tee ~/gitpack-tests-output >&2 && # store output

if ! tests_status="$(cat ~/gitpack-tests-status)"; then # load exit status
    echo 'cannot get exit status of tests' >&2; exit 1
fi &&

if [ "$tests_status" -eq 0 ]; then # if tests were successful, watch output
    # check if there is an error message (ignoring a diagnostic message format)
    echo testtests1 >&2 && while read -r line; do
        # if it does not match the diagnostic format, it is an error message
        if ! echo "$line" | grep -q '^[[:alpha:]]\+[[:digit:]]\+$'; then
            echo "error detected: $line" >&2; exit 1
        fi
    done < ~/gitpack-tests-output &&
    exit 0 # success
else
    exit "$tests_status" # fail
fi
