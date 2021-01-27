#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019-2021 Dominik Salvet
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
    echo "running $1"
    test_name="$(echo "$1" | sed 's|/|_|g; s/\.sh$//')" && # derive test name

    # run test and store its execution trace
    if ! test_trace="$(sh -eux "$1" 2>&1)"; then
        echo 'recent trace (more in artifacts):'
        echo "$test_trace" | tail -n 20 && # recent trace
        echo "failed $1" &&
        echo "$test_trace" > "$TRACE_DIR/failed_$test_name" &&
        return 1
    else
        echo "passed $1"
        # if test is run multiple times, only latest successful trace is kept
        echo "$test_trace" > "$TRACE_DIR/passed_$test_name"
    fi
)

#-------------------------------------------------------------------------------
# INITIALIZE CONSTANTS
#-------------------------------------------------------------------------------

export HASH="${GITHUB_SHA:?}" && # current commit hash
SHORT_HASH="$(echo "$HASH" | cut -c 1-7)" &&
export SHORT_HASH &&

export GITPACK='sh -x src/gitpack' && # GitPack with tracing enabled
export SUDO_GITPACK='sudo sh -x src/gitpack' && # root permissions
export URL=github.com/dominiksalvet/gitpack &&
export VERSION=ci-version && # latest GitPack version
export VERSION_HASH=b2842a2affe769f2aeb1c03bba2a299eb2959ea7 &&
export VERSION_SHORT_HASH=b2842a2 &&
export OLD_VERSION=ci-old-version &&

export EXTRA_URL=github.com/dominiksalvet/sandbox && # needed in some tests
export EXTRA_VERSION=beforecommit && # use this and only this version

case "${MATRIX_OS:?}" in
    windows-*) export USE_SUDO=false ;;
    *) export USE_SUDO=true ;;
esac &&

#-------------------------------------------------------------------------------
# FILE PATHS
#-------------------------------------------------------------------------------

system="$(uname)" &&
case "$system" in
    Linux)  export LOCAL_STATE_DIR="$HOME/.local/share/gitpack"
            export GLOBAL_STATE_DIR=/var/lib/gitpack
            export LOCAL_CACHE_DIR="$HOME/.cache/gitpack"
            export GLOBAL_CACHE_DIR=/var/cache/gitpack
            export LOCK_DIR=/var/lock
            ;;
    Darwin) export LOCAL_STATE_DIR="$HOME/.local/share/gitpack"
            export GLOBAL_STATE_DIR=/var/lib/gitpack
            export LOCAL_CACHE_DIR="$HOME/Library/Caches/gitpack"
            export GLOBAL_CACHE_DIR=/Library/Caches/gitpack
            export LOCK_DIR=/tmp
            ;;
    *)  export LOCAL_STATE_DIR="$HOME/.local/share/gitpack"
        export GLOBAL_STATE_DIR=/var/lib/gitpack
        export LOCAL_CACHE_DIR="$HOME/.cache/gitpack"
        export GLOBAL_CACHE_DIR=/var/cache/gitpack
        export LOCK_DIR=/tmp
        ;;
esac &&

#-------------------------------------------------------------------------------
# EXECUTION TRACING
#-------------------------------------------------------------------------------

readonly TRACE_DIR=gitpack-trace && # trace artifacts storage
mkdir -p "$TRACE_DIR/" &&

#-------------------------------------------------------------------------------
# RUN TESTS
#-------------------------------------------------------------------------------

# actions API
run_test test/action-api/status.sh &&
run_test test/action-api/install.sh &&
run_test test/action-api/update.sh &&
run_test test/action-api/downgrade.sh &&

# commands API
run_test test/command-api/messages.sh &&
run_test test/command-api/paths.sh &&
run_test test/command-api/list.sh &&
run_test test/command-api/clean.sh &&

# feature testing
run_test test/helper/clean-files.sh &&
run_test test/feature/install.sh &&
run_test test/feature/uninstall.sh &&
run_test test/feature/install-multiple.sh &&
run_test test/feature/install-local-global.sh &&
run_test test/feature/clean.sh &&

# tests that cannot succeed
run_test test/xfail/args.sh &&
run_test test/xfail/urls.sh &&

# install current commit
run_test test/helper/clean-files.sh &&
run_test test/feature/self-install.sh
