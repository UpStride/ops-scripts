#!/usr/bin/env bash
# Test scripts are no making any harm for a dry run
# generic error
function error() {
  echo "x failed" && exit 2;
}

# initial checksum
# shellcheck disable=SC2012
checksum_1=$(ls -lnAR --time-style=+%s tests/data/void | md5sum|cut -d ' ' -f1)
echo "#1 dry run of 'compute-audio-space'"
bash compute-audio-space/run -s tests/data/void >/dev/null  || error
echo "#2 dry run of 'reverse-audio'"
bash reverse-audio/run -s tests/data/void >/dev/null || error
echo "#3 dry run of 'browse-github'"
bash browse-github/run -o xxx >/dev/null 2>/dev/null || error
echo "#3 check if no files modified"
# shellcheck disable=SC2012
checksum_2=$(ls -lnAR --time-style=+%s tests/data/void | md5sum|cut -d ' ' -f1)
[ "$checksum_1" != "$checksum_2" ] && error
echo "#alright!"
