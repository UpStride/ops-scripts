#!/usr/bin/env bash
# compute fourier transform graph

# load utility functions
source "$(dirname "$0")/utils.sh"

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
mv tests/data/audio/special-cases/a_a_a.wav "tests/data/audio/special-cases/a'a a.wav" || error
bash compute-audio-space/run -s tests/data/audio/special-cases >/dev/null || error
check_content tests/data/audio/special-cases/.fft 'image/png'
check_content tests/data/audio/special-cases/.palindromic 'audio/x-wav'
check_content tests/data/audio/special-cases/.reversed 'audio/x-wav'
echo "#alright!"
