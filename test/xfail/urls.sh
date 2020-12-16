#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2020 Dominik Salvet
# https://github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------

# shellcheck disable=SC2034

out1="$(! $GITPACK status '')"
out2="$(! $GITPACK status 'bad url')"
out3="$(! $GITPACK status 'bad
url')"
out4="$(! $GITPACK status .)"
out5="$(! $GITPACK status ..)"
out6="$(! $GITPACK status "$URL"/.)"
out7="$(! $GITPACK status "$URL"/..)"
out8="$(! $GITPACK status ./"$URL")"
out9="$(! $GITPACK status ../"$URL")"
out10="$(! $GITPACK status badurl/./badurl)"
out11="$(! $GITPACK status badurl/../badurl)"

out12="$(! $GITPACK status 'github.com/dominik
salvet/gitpack')"
out13="$(! $GITPACK status "$URL=
HEAD")"
out14="$(! $GITPACK status "$URL=HE
AD")"
out15="$(! $GITPACK status "$URL=HEAD
")"
