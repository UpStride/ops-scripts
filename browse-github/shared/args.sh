while getopts :o:l: flag
do
    case "${flag}" in
        o) ORGANIZATION_NAME=${OPTARG};;
        l) REPO_NAMES=${OPTARG};;
        *)
          usage
          exit 0
          ;;
    esac
done

! [ -n "$ORGANIZATION_NAME" ] && echo "*organization name not found*" && usage && exit 2
