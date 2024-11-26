#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019-2024 Dominik Salvet
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
        echo "failed $1" &&
        echo "$test_trace" > "$TRACE_DIR/failed_$test_name" &&
        return 1
    else
        echo "passed $1" &&
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
export VERSION=1.1.0 && # latest GitPack version
export VERSION_HASH=d6cf61871c93e89b5c622d77ff8fa517da5d3ce0 &&
export VERSION_SHORT_HASH=d6cf618 &&
export OLD_VERSION=1.0.0 &&
export OLD_VERSION_HASH=7fb5b5fad69002fc17421ef8b5809521f6b200c0 &&

export EXTRA_URL=github.com/dominiksalvet/nconv && # needed in some tests
export EXTRA_VERSION=1.1.0 && # use this and only this version
export EXTRA_VERSION_HASH=8fbccd124e723b023a32c6ebfb2fd2d10d22fade &&

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
            export LOCK_DIR=/tmp
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
run_test test/api/status.sh &&
run_test test/api/install.sh &&
run_test test/api/update.sh &&
run_test test/api/downgrade.sh &&

# commands API
run_test test/api/messages.sh &&
run_test test/api/paths.sh &&
run_test test/api/list.sh &&
run_test test/api/clean.sh &&

# feature testing
run_test test/helper/clean-files.sh &&
run_test test/feature/install.sh &&
run_test test/feature/uninstall.sh &&
run_test test/feature/install-multiple.sh &&
run_test test/feature/install-local-global.sh &&
run_test test/feature/basename-duplicates.sh &&
run_test test/feature/mutual-exclusion.sh &&
run_test test/feature/clean.sh &&

# tests that cannot succeed
run_test test/xfail/args.sh &&
run_test test/xfail/urls.sh &&

# install current commit
run_test test/helper/clean-files.sh &&
run_test test/feature/self-install.sh
