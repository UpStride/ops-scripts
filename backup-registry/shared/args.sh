while getopts :h:g:t: flag
do
    case "${flag}" in
        h) REGISTRY_HOST=${OPTARG};;
        g) GOOGLE_DRIVE=${OPTARG};;
        t) ACCESS_TOKEN=${OPTARG};;
        *)
          usage
          exit 0
          ;;
    esac
done

! [ -n "$REGISTRY_HOST" ] && echo "*Host not found*" && usage && exit 2
! [ -n "$GOOGLE_DRIVE" ] && echo "*Google drive destination not given*" && usage && exit 2
! [ -n "$ACCESS_TOKEN" ] && echo "*Google drive access token not given*" && usage && exit 2
