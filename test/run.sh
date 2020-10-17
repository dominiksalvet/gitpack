#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019-2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   Initializes test environment and manages running all GitPack tests. The
#   current working directory must be set to the Git root directory.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------------------

# DESCRIPTION:
#   Runs a single given test with all associated output messages. If the given
#   test fails, it will print its execution trace.
# PARAMETERS:
#   $1 - test path
run_test() (
    printf '%s' "$1" || return # print test path before executing

    # run test and store execution trace
    if ! test_trace="$(sh -x "$1" 2>&1)"; then # test failed
        printf ' fail\n' &&
        echo "$test_trace" | tail -n 100 && # print recent execution trace
        return 1 # indicate test fail
    else
        printf ' pass\n'
    fi
)

#-------------------------------------------------------------------------------
# ENVIRONMENT
#-------------------------------------------------------------------------------

# prepare current commit variables
export COMMIT="${GITHUB_SHA:?}" && # export commit to the current environment
SHORT_COMMIT="$(echo "$COMMIT" | cut -c 1-7)" && # short commit hash
export SHORT_COMMIT &&

# prepare GitPack related variables
export GITPACK='sh -x src/gitpack' && # GitPack is run with tracing enabled
export GITPACK_URL=github.com/dominiksalvet/gitpack && # GitPack Git URL
export GITPACK_VERSION=0.7.0 && # latest GitPack version
export GITPACK_OLD_VERSION=0.1.0 && # older GitPack version

#-------------------------------------------------------------------------------
# RUN TESTS
#-------------------------------------------------------------------------------

# test GitPack actions
run_test test/action/status.sh &&
run_test test/action/install.sh &&
run_test test/action/update.sh &&
run_test test/action/downgrade.sh
