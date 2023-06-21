while getopts :o: flag
do
    case "${flag}" in
        o) ORGANIZATION_NAME=${OPTARG};;
        *)
          usage
          exit 0
          ;;
    esac
done

[ -z "$ORGANIZATION_NAME" ] && echo "*organization name not provided*" && usage && exit 2

