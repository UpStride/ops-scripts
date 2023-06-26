#!/usr/bin/env bash
# computation of fourier graph with sub-slicing

# load utility functions
source "$(dirname "$0")/utils.sh"

ROOT_DIR="$(dirname "$0")"/..

echo "#0 'compute-audio-space' single audio"
bash "$ROOT_DIR"/compute-audio-space/run -s "$ROOT_DIR"/tests/data/audio/single-file -m expensive >/dev/null || error
check_content "$ROOT_DIR"/tests/data/audio/single-file/.fft 'image/png'
check_content "$ROOT_DIR"/tests/data/audio/single-file/.palindromic 'audio/x-wav'
check_content "$ROOT_DIR"/tests/data/audio/single-file/.reversed 'audio/x-wav'
[ "$(find "$ROOT_DIR/tests/data/audio/single-file/.fft" -maxdepth 1 -iname '*.png'| wc -l)" -ne 3 ] && echo "number of chopped audio <> 3" && error

echo "#2 'compute-audio-space' multiple audio(s)"
bash "$ROOT_DIR"/compute-audio-space/run -s "$ROOT_DIR"/tests/data/audio/multiple-files >/dev/null || error
check_content "$ROOT_DIR"/tests/data/audio/multiple-files/.fft 'image/png'
check_content "$ROOT_DIR"/tests/data/audio/multiple-files/.palindromic 'audio/x-wav'
check_content "$ROOT_DIR"/tests/data/audio/multiple-files/.reversed 'audio/x-wav'

echo "#alright!"
