#!/bin/sh

#-------------------------------------------------------------------------------
# Copyright 2019 Dominik Salvet
# github.com/dominiksalvet/gitpack
#-------------------------------------------------------------------------------
# DESCRIPTION:
#   This test checks correct GitPack execution logging to a log file. The
#   current state of execution is reported to stderr.
#-------------------------------------------------------------------------------

# remove the log to initialize this test
echo logging1 >&2 && rm -f ~/.local/share/gitpack/gitpack.log &&

# basic functions
echo logging2 >&2 && gitpack about &&
gitpack help &&
gitpack clean && # clean cache
# check affected log items
echo logging3 >&2 && test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging4 >&2 && test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging5 >&2 && test "$(grep -Fc '[clean]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging6 >&2 && test "$(grep -Fc '[backup]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging7 >&2 && test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging8 >&2 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 5 &&

# install an example project, vhdldep, in version 2.1.0 (not the latest release)
echo logging9 >&2 && gitpack status github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install -o github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install -o github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status -o github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check affected log items
echo logging10 >&2 && test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo logging11 >&2 && test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo logging12 >&2 && test "$(grep -Fc '[backup]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo logging13 >&2 && test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 6 &&
echo logging14 >&2 && test "$(grep -Fc '[action]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging15 >&2 && test "$(grep -Fc '[url]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging16 >&2 && test "$(grep -Fc '[refresh]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging17 >&2 && test "$(grep -Fc '[execute]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging18 >&2 && test "$(grep -Fc '[get]' ~/.local/share/gitpack/gitpack.log)" -eq 4 &&
echo logging19 >&2 && test "$(grep -Fc '[cp]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging20 >&2 && test "$(grep -Fc '[insert]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging21 >&2 && test "$(grep -Fc '[list]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging22 >&2 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 48 &&

# update to the latest version
echo logging23 >&2 && gitpack status -o github.com/dominiksalvet/vhdldep &&
gitpack install -o github.com/dominiksalvet/vhdldep &&
gitpack install -o github.com/dominiksalvet/vhdldep &&
gitpack status -o github.com/dominiksalvet/vhdldep &&
gitpack list &&
# check affected log items
echo logging24 >&2 && test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo logging25 >&2 && test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo logging26 >&2 && test "$(grep -Fc '[backup]' ~/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo logging27 >&2 && test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 11 &&
echo logging28 >&2 && test "$(grep -Fc '[action]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging29 >&2 && test "$(grep -Fc '[url]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging30 >&2 && test "$(grep -Fc '[refresh]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging31 >&2 && test "$(grep -Fc '[execute]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging32 >&2 && test "$(grep -Fc '[get]' ~/.local/share/gitpack/gitpack.log)" -eq 8 &&
echo logging33 >&2 && test "$(grep -Fc '[cp]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging34 >&2 && test "$(grep -Fc '[insert]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging35 >&2 && test "$(grep -Fc '[list]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging36 >&2 && test "$(grep -Fc '[rm]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging37 >&2 && test "$(grep -Fc '[delete]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging38 >&2 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 93 &&

# downgrade back to 2.1.0
echo logging39 >&2 && gitpack status -o github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install -o github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack install -o github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack status -o github.com/dominiksalvet/vhdldep=2.1.0 &&
gitpack list &&
# check affected log items
echo logging40 >&2 && test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging41 >&2 && test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging42 >&2 && test "$(grep -Fc '[backup]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging43 >&2 && test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging44 >&2 && test "$(grep -Fc '[action]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging45 >&2 && test "$(grep -Fc '[url]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging46 >&2 && test "$(grep -Fc '[refresh]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging47 >&2 && test "$(grep -Fc '[execute]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging48 >&2 && test "$(grep -Fc '[get]' ~/.local/share/gitpack/gitpack.log)" -eq 12 &&
echo logging49 >&2 && test "$(grep -Fc '[cp]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging50 >&2 && test "$(grep -Fc '[insert]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging51 >&2 && test "$(grep -Fc '[list]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging52 >&2 && test "$(grep -Fc '[rm]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging53 >&2 && test "$(grep -Fc '[delete]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging54 >&2 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 138 &&

# uninstall vhdldep
echo logging55 >&2 && gitpack uninstall -o github.com/dominiksalvet/vhdldep &&
gitpack uninstall -o github.com/dominiksalvet/vhdldep &&
gitpack status -o github.com/dominiksalvet/vhdldep &&
# check affected log items
echo logging56 >&2 && test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo logging57 >&2 && test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo logging58 >&2 && test "$(grep -Fc '[backup]' ~/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo logging59 >&2 && test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 19 &&
echo logging60 >&2 && test "$(grep -Fc '[action]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging61 >&2 && test "$(grep -Fc '[url]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging62 >&2 && test "$(grep -Fc '[refresh]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging63 >&2 && test "$(grep -Fc '[execute]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging64 >&2 && test "$(grep -Fc '[get]' ~/.local/share/gitpack/gitpack.log)" -eq 15 &&
echo logging65 >&2 && test "$(grep -Fc '[cp]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging66 >&2 && test "$(grep -Fc '[insert]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging67 >&2 && test "$(grep -Fc '[list]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging68 >&2 && test "$(grep -Fc '[rm]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging69 >&2 && test "$(grep -Fc '[delete]' ~/.local/share/gitpack/gitpack.log)" -eq 3 &&
echo logging70 >&2 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 167 &&

# intentionally bad URL
echo logging71 >&2 && ! gitpack status github.com/a/b/c 2>&1 &&
# check affected log items
echo logging72 >&2 && test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo logging73 >&2 && test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo logging74 >&2 && test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo logging75 >&2 && test "$(grep -Fc '[action]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging76 >&2 && test "$(grep -Fc '[url]' ~/.local/share/gitpack/gitpack.log)" -eq 16 &&
echo logging77 >&2 && test "$(grep -Fc '[fail]' ~/.local/share/gitpack/gitpack.log)" -eq 1 &&
echo logging78 >&2 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 173 &&

# clean cache again
echo logging79 >&2 && gitpack clean &&
# check affected log items
echo logging80 >&2 && test "$(grep -Fc '[log]' ~/.local/share/gitpack/gitpack.log)" -eq 21 &&
echo logging81 >&2 && test "$(grep -Fc '[db]' ~/.local/share/gitpack/gitpack.log)" -eq 21 &&
echo logging82 >&2 && test "$(grep -Fc '[clean]' ~/.local/share/gitpack/gitpack.log)" -eq 2 &&
echo logging83 >&2 && test "$(grep -Fc '[backup]' ~/.local/share/gitpack/gitpack.log)" -eq 20 &&
echo logging84 >&2 && test "$(grep -Fc '[exit]' ~/.local/share/gitpack/gitpack.log)" -eq 21 &&
echo logging85 >&2 && test "$(wc -l < ~/.local/share/gitpack/gitpack.log)" -eq 178
