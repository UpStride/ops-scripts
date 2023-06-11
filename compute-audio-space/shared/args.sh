while getopts :s: flag
do
    case "${flag}" in
        s) SOURCE_DIRECTORY=${OPTARG};;
        *)
          usage
          exit 0
          ;;
    esac
done

! [ -n "$SOURCE_DIRECTORY" -a -d "$SOURCE_DIRECTORY" ] && echo "*Directory not given*" && usage && exit 2
