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
    echo "$?" > "$HOME"/gitpack-tests-status 2>/dev/null # store exit status
} | tee "$HOME"/gitpack-tests-output >&2 && # store output

if ! tests_status="$(cat "$HOME"/gitpack-tests-status)"; then # load exit status
    echo 'cannot get exit status of tests' >&2; exit 1
fi &&

if [ "$tests_status" -eq 0 ]; then # if tests were successful, check output
    # check if there is an error message (ignoring a diagnostic message format)
    echo testtests1 >&2 && while IFS= read -r line; do
        # if it does not match the diagnostic format, it is an error message
        if ! echo "$line" | grep -q '^[[:alpha:]]\+[[:digit:]]\+$'; then
            echo "error detected: $line" >&2; exit 1
        fi
    done < "$HOME"/gitpack-tests-output &&

    # check if test numbers are sorted
    echo testtests2 >&2 && prev_testno=0 &&
    while IFS= read -r line; do
        testno="$(echo "$line" | tr -dC '[:digit:]')" && # extract test number
        if [ "$testno" -eq "$((prev_testno + 1))" ] || [ "$testno" -eq 1 ]; then
            prev_testno="$testno" # store current test number for next test
        else
            echo "$line is not sorted" >&2; exit 1
        fi || exit
    done < "$HOME"/gitpack-tests-output
else
    exit "$tests_status" # fail
fi
