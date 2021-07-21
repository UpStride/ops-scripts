function upload {
  ! [ -f "$1" ] && echo "File missing" && exit 2
  curl -s -X POST -L \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -F "metadata={name :'$1', parents: ['$GOOGLE_DRIVE']};type=application/json;charset=UTF-8;" \
    -F "file=@$1;type=$(file -b --mime-type $1)" \
    "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart"
}