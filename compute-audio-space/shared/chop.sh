function chop(){
  t0=$(ffprobe -i $1 -show_entries format=duration -v quiet -of csv="p=0")
  t1=$(awk "BEGIN {print $t0/2.0}")
  ffmpeg -y -i "$1" -ss 0 -to "$t1" -c copy "$2" >/dev/null 2>/dev/null
}

function clear_chopped(){
  old_chopped=$(find "." -maxdepth 1 -iname '*.y.wav')
  [ -z "$old_chopped" ] && return 0
  while read -r filename; do
      rm "$filename"
  done <<< "$old_chopped"
}

audio_files=$(realpath "$SOURCE_DIRECTORY")
info "=> chopping audio files"
cd "$audio_files" || exit 2
info "+ clearing old '.y.wav'"
clear_chopped
LIST=$(find "." -maxdepth 1 -iname '*.wav')
[ -z "$LIST" ] && info "x no audio files found" && exit 0
info "+ audio file(s) found"
info "+ chopping audio file(s)"
while read -r filename; do
    chop "$filename" "${filename//.wav/.y.wav}"
    chop "${filename//.wav/.y.wav}" "${filename//.wav/.y.y.wav}"
done <<< "$LIST"
cd "$CWD" || exit 2