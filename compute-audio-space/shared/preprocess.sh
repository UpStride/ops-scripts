audio_files=$(realpath "$SOURCE_DIRECTORY")
CWD=$PWD
#Converting MP3/OGG files to wav
info "=> checking MP3/OGG"
MP3=$(cd "$audio_files" && find "." -maxdepth 1 -iname '*.mp3' -o -iname '*.ogg' -o -iname '*.m4a')
[ -n "$MP3" ] && {
  info "+ converting MP3/OGG"
  for file in ${MP3[*]}; do
    {  ffmpeg -y -i "$audio_files/$file" "$audio_files/${file##*/}.wav" >/dev/null 2>/dev/null  ; }
  done || cd $CWD
}

info "=> checking audio files"
cd "$audio_files" || exit 2
LIST=$(find "." -maxdepth 1 -iname '*.wav')
[ -z "$LIST" ] && info "x no audio files found" && exit 0
info "+ audio file(s) found"
info "+ checking special characters"
while read -r filename; do
    legit_name "$filename"
done <<< "$LIST"
cd "$CWD" || exit 2