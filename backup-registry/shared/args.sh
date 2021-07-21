while getopts :n:h: flag
do
    case "${flag}" in
        n) REGISTRY_NAME=${OPTARG};;
        h) REGISTRY_HOST=${OPTARG};;
        *)
          usage
          exit 0
          ;;
    esac
done

! [ -n "$REGISTRY_NAME" ] && echo "Registry not found" && usage && exit 2
! [ -n "$REGISTRY_HOST" ] && echo "Host not found" && usage && exit 2
