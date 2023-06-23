while getopts :m:s: flag
do
    case "${flag}" in
        m) COMPUTE_METHOD=${OPTARG};;
        s) SOURCE_DIRECTORY=${OPTARG};;
        *)
          usage
          exit 0
          ;;
    esac
done

! [ -n "$SOURCE_DIRECTORY" -a -d "$SOURCE_DIRECTORY" ] && echo "*Directory not given*" && usage && exit 2
! [ -n "$COMPUTE_METHOD" ] && info "*Compute Method is Default*"