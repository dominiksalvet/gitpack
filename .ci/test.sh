#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Initializes and runs GitPack tests. If they are successful, it also analyses
#   their output due possible issues. The current state of execution is reported
#   to stderr.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# INITIALIZATION
#-------------------------------------------------------------------------------

# prepare and export constants used in actual tests
echo inittests1 >&2 && export COMMIT="${TRAVIS_COMMIT:?}" &&
echo inittests2 >&2 && SHORT_COMMIT="$(echo "$COMMIT" | cut -c 1-7)" &&
echo inittests3 >&2 && export SHORT_COMMIT &&

#-------------------------------------------------------------------------------
# RUN TESTS
#-------------------------------------------------------------------------------

# run all tests and store their exit status and output for further analysis
{   .ci/tests.sh 2>&1 1>/dev/null
    echo "$?" > "$HOME"/gitpack-tests-status 2>/dev/null # store exit status
} | tee "$HOME"/gitpack-tests-output >&2 && # store output

tests_status="$(cat "$HOME"/gitpack-tests-status)" && # load exit status
test "$tests_status" -eq 0 || exit # fail if there was a problem

#-------------------------------------------------------------------------------
# CHECK TESTS OUTPUT
#-------------------------------------------------------------------------------

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
        echo "test $line is not sorted" >&2; exit 1
    fi || exit
done < "$HOME"/gitpack-tests-output
