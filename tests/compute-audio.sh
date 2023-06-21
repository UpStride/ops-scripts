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

echo "#1 'compute-audio-space' single audio"
bash compute-audio-space/run -s tests/data/audio/single-file >/dev/null || error
check_content tests/data/audio/single-file/.fft 'image/png'
check_content tests/data/audio/single-file/.palindromic 'audio/x-wav'
check_content tests/data/audio/single-file/.reversed 'audio/x-wav'

echo "#2 'compute-audio-space' multiple audio(s)"
bash compute-audio-space/run -s tests/data/audio/multiple-files >/dev/null || error
check_content tests/data/audio/multiple-files/.fft 'image/png'
check_content tests/data/audio/multiple-files/.palindromic 'audio/x-wav'
check_content tests/data/audio/multiple-files/.reversed 'audio/x-wav'

echo "#3 'compute-audio-space' pathologic file(s)"
mv tests/data/audio/special-characters/a_a_a.wav "tests/data/audio/special-characters/a'a a.wav" || error
bash compute-audio-space/run -s tests/data/audio/special-characters >/dev/null || error
check_content tests/data/audio/special-characters/.fft 'image/png'
check_content tests/data/audio/special-characters/.palindromic 'audio/x-wav'
check_content tests/data/audio/special-characters/.reversed 'audio/x-wav'
echo "#alright!"
