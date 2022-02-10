while getopts :u:d: flag
do
    case "${flag}" in
        u) URLS=${OPTARG};;
        d) DIRECTORY=${OPTARG};;
        *)
          usage
          exit 0
          ;;
    esac
done

! [ -n "$URLS" -a -f "$URLS" ] && echo "*Urls not found*" && usage && exit 2
! [ -n "$DIRECTORY" -a -d "$DIRECTORY" ] && echo "*Directory not given*" && usage && exit 2
