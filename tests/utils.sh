# generic error
function error() {
  echo "x failed" && exit 2;
}

# check if all files in a directory are of a certain type
function check_content(){
  # shellcheck disable=SC2044
  LIST=$(find "$1" -maxdepth 1 -type f)
  [ -z "$LIST" ] && error
  while read -r file; do
    [ "$(file -b --mime-type "$file")" != "$2" ] && echo "$file is not of type $2" && error
  done <<< "$LIST"
}