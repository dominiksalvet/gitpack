#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019-2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# Initializes test environment and runs all GitPack test. The current working
# directory must be set to the GitPack repository directory. It is expected to
# be run in isolation, for example in a Docker container.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------------------

# $1 - test path
run_test() (
    printf '%s' "$1" || return

    # run test and store its execution trace
    if ! test_trace="$(sh -x "$1" 2>&1)"; then
        printf ' fail\n' &&
        echo "$test_trace" | tail -n 100 &&
        return 1
    else
        printf ' pass\n'
    fi
)

#-------------------------------------------------------------------------------
# ENVIRONMENT INITIALIZATION
#-------------------------------------------------------------------------------

export GITPACK='sh -x src/gitpack' && # GitPack is run with tracing enabled
export URL=github.com/dominiksalvet/gitpack &&
export NEW_VERSION=0.7.0 &&
export OLD_VERSION=0.1.0 &&

export HASH="${GITHUB_SHA:?}" && # current commit hash
SHORT_HASH="$(echo "$HASH" | cut -c 1-7)" &&
export SHORT_HASH &&

#-------------------------------------------------------------------------------
# RUN TESTS
#-------------------------------------------------------------------------------

run_test test/action-api/status.sh &&
run_test test/action-api/install.sh &&
run_test test/action-api/update.sh &&
run_test test/action-api/downgrade.sh
