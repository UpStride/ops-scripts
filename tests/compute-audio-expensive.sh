#!/usr/bin/env bash
# Test scripts are no making any harm for a dry run
# generic error
function error() {
  echo "x failed" && exit 2;
}

function check_content(){
  for file in $(find "$1" -maxdepth 1 -type f ); do
     [ "$(file -b --mime-type "$file")" != "$2" ] && echo "$file is not of type $2" && error
  done
}

ROOT_DIR="$(dirname "$0")"/..

echo "#0 'compute-audio-space' single audio"
bash "$ROOT_DIR"/compute-audio-space/run -s "$ROOT_DIR"/tests/data/audio/single-file -m expensive >/dev/null || error
check_content "$ROOT_DIR"/tests/data/audio/single-file/.fft 'image/png'
check_content "$ROOT_DIR"/tests/data/audio/single-file/.palindromic 'audio/x-wav'
check_content "$ROOT_DIR"/tests/data/audio/single-file/.reversed 'audio/x-wav'
[ "$(find "$ROOT_DIR/tests/data/audio/single-file/.fft" -maxdepth 1 -iname '*.png'| wc -l)" -ne 3 ] && echo "number of chopped audio <> 3" && error
echo "#alright!"
