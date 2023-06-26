#!/usr/bin/env bash
# compute fourier transform graph

# load utility functions
source "$(dirname "$0")/utils.sh"

ROOT_DIR="$(dirname "$0")"/..

echo "#1 'compute-audio-space' single audio"
bash "$ROOT_DIR"/compute-audio-space/run -s "$ROOT_DIR"/tests/data/audio/single-file >/dev/null || error
check_content "$ROOT_DIR"/tests/data/audio/single-file/.fft 'image/png'
check_content "$ROOT_DIR"/tests/data/audio/single-file/.palindromic 'audio/x-wav'
check_content "$ROOT_DIR"/tests/data/audio/single-file/.reversed 'audio/x-wav'

echo "#2 'compute-audio-space' pathologic file(s)"
mv "$ROOT_DIR"/tests/data/audio/special-cases/a_a_a.wav "$ROOT_DIR/tests/data/audio/special-cases/a'a a.wav" || error
bash "$ROOT_DIR"/compute-audio-space/run -s "$ROOT_DIR"/tests/data/audio/special-cases >/dev/null || error
check_content "$ROOT_DIR"/tests/data/audio/special-cases/.fft 'image/png'
check_content "$ROOT_DIR"/tests/data/audio/special-cases/.palindromic 'audio/x-wav'
check_content "$ROOT_DIR"/tests/data/audio/special-cases/.reversed 'audio/x-wav'
echo "#alright!"
