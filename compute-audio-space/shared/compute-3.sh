#Compute reverted audio files
audio_files=$(realpath "$SOURCE_DIRECTORY")
ROOT_DIR=$(realpath "$(dirname "$0")/..")
info "=> reverting audio files"
bash "$ROOT_DIR"/reverse-audio/run -s "$audio_files"

#Compute FFT of original / reverted / palindromic audio file
info "=> fft audio files"
[ -d "$audio_files/.fft/" ] && { info "+ clearing .fft directory"; rm -r "$audio_files/.fft/"; }
mkdir "$audio_files/.fft/"
declare -i TOTAL=0
LIST=$(cd "$audio_files" && find "." -maxdepth 1 -iname '*.wav')
info "+ entering computation loop";
while read -r filename; do
    {  info "++ file #$TOTAL: $filename"\
    && python3 "$ROOT_DIR/compute-audio-space/shared/scripts.py" fft -a "$audio_files/$filename" "$audio_files/.reversed/${filename,,}" "$audio_files/.palindromic/${filename,,}" -o "$audio_files/.fft/${filename,,}.png" \
         && TOTAL=$TOTAL+1 ; }
done <<< "$LIST" && echo "total computed: $TOTAL"