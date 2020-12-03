#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# local paths
user_id="$(id -u)" &&
out="$($GITPACK paths)" &&
test "$out" = "state-dir $HOME/.local/share/gitpack
cache-dir $HOME/.cache/gitpack
lock-path /var/lock/gitpack-$user_id" &&

# global paths
root_id="$(sudo id -u)" &&
out="$($SUDO_GITPACK paths)" &&
test "$out" = "state-dir /var/lib/gitpack
cache-dir /var/cache/gitpack
lock-path /var/lock/gitpack-$root_id"
