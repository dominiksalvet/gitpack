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
    echo "$?" 2>&1 1>~/gitpack-tester-status # store exit status
} | tee ~/gitpack-tester-output && # store output

tester_status="$(cat ~/gitpack-tester-status)" && # load exit status
if [ "$tester_status" -eq 0 ]; then # if tests were successful
    # check if there is an error message (ignoring a diagnostic message format)
    while read -r line; do
        # if it does not match the diagnostic format, it is an error message
        if ! echo "$line" | grep '^[[:alpha:]]\+[[:digit:]]\+$'; then
            echo "error detected: $line" >&2; exit 1
        fi
    done < ~/gitpack-tester-output &&
    exit 0 # success
else
    exit "$tester_status" # fail
fi
