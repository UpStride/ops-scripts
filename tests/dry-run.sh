#!/usr/bin/env bash
# Test scripts are no making any harm for a dry run

# load utility functions
source "$(dirname "$0")/utils.sh"

# initial checksum
# shellcheck disable=SC2012
checksum_1=$(ls -lnAR --time-style=+%s tests/data/void | md5sum|cut -d ' ' -f1)
echo "#1 dry run of 'compute-audio-space'"
bash compute-audio-space/run -s tests/data/void >/dev/null  || error
echo "#2 dry run of 'reverse-audio'"
bash reverse-audio/run -s tests/data/void >/dev/null || error
echo "#3 dry run of 'browse-github'"
bash browse-github/run -o xxx >/dev/null 2>/dev/null || error
echo "#4 check if no files modified with checksums"
# shellcheck disable=SC2012
# final checksum
checksum_2=$(ls -lnAR --time-style=+%s tests/data/void | md5sum|cut -d ' ' -f1)
[ "$checksum_1" != "$checksum_2" ] && error
echo "#alright!"
