#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019-2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# Initializes test environment and runs all GitPack tests. The current working
# directory must be set to the GitPack repository directory. It is expected to
# be run in isolation, for example in a Docker container.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------------------

# $1 - test path
run_test() (
    echo "running $1" &&
    test_name="$(echo "$1" | sed 's|/|_|g; s/\.sh$//')" && # derive test name

    # run test and store its execution trace
    if ! test_trace="$(sh -eux "$1" 2>&1)"; then
        echo 'recent trace (more in artifacts):' &&
        echo "$test_trace" | tail -n 20 && # recent trace
        echo "$1 failed" &&
        echo "$test_trace" > "$TRACE_DIR"/failed_"$test_name" &&
        return 1
    else
        echo "$1 passed" &&
        echo "$test_trace" > "$TRACE_DIR"/passed_"$test_name"
    fi
)

#-------------------------------------------------------------------------------
# INITIALIZE VARIABLES
#-------------------------------------------------------------------------------

export HASH="${GITHUB_SHA:?}" && # current commit hash
SHORT_HASH="$(echo "$HASH" | cut -c 1-7)" &&
export SHORT_HASH &&

export GITPACK='sh -x src/gitpack' && # GitPack is run with tracing enabled
export SUDO_GITPACK='sudo sh -x src/gitpack' && # root permissions
export URL=github.com/dominiksalvet/gitpack &&
export VERSION=remaster-version && # latest GitPack version
export VERSION_HASH=b2842a2affe769f2aeb1c03bba2a299eb2959ea7 &&
export VERSION_SHORT_HASH=b2842a2 &&
export OLD_VERSION=remaster-old-version &&

export EXTRA_URL=github.com/dominiksalvet/sandbox && # needed in some tests
export EXTRA_VERSION=beforecommit && # use this and only this version

#-------------------------------------------------------------------------------
# INITIALIZE FILES
#-------------------------------------------------------------------------------

readonly TRACE_DIR=gitpack-trace && # trace artifacts storage
mkdir -p "$TRACE_DIR"/ &&

#-------------------------------------------------------------------------------
# RUN TESTS
#-------------------------------------------------------------------------------

# actions API
run_test test/action-api/status.sh &&
run_test test/action-api/install.sh &&
run_test test/action-api/update.sh &&
run_test test/action-api/downgrade.sh &&
run_test test/action-api/install-multiple.sh &&
run_test test/action-api/local-global.sh &&

# commands API
run_test test/command-api/messages.sh &&
run_test test/command-api/paths.sh &&
run_test test/command-api/list.sh &&
run_test test/command-api/clean.sh &&

# check install files
run_test test/storage/no-install-files.sh &&
run_test test/subcommand/install.sh &&
run_test test/subcommand/uninstall.sh &&

# install current commit
run_test test/subcommand/clean.sh &&
run_test test/storage/remove-empty-state.sh &&
run_test test/subcommand/self-install.sh &&

# tests that cannot succeed
run_test test/xfail/args.sh &&
run_test test/xfail/urls.sh
