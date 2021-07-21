while getopts :r: flag
do
    case "${flag}" in
        r) CSV=$(realpath ${OPTARG});;
        *)
          usage
          exit 0
          ;;
    esac
done

! [ -f "$CSV" ] && echo "File not found" && usage && exit 2
