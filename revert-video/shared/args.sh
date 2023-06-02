while getopts :d: flag
do
    case "${flag}" in
        d) DIRECTORY=${OPTARG};;
        *)
          usage
          exit 0
          ;;
    esac
done

! [ -n "$DIRECTORY" -a -d "$DIRECTORY" ] && echo "*Directory not given*" && usage && exit 2
