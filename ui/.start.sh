# UI part of futil.screend.start.sh
# This is not even a script, stupid and can't exist alone. It is purely
# ment for beeing included.

function print_screend.start_help() {
			cat <<EOF
Usage:
   ${SCREEND_START_SH_INFO} [options]

Start a daemonized screen suitable for scripting commands to various X-sessions


Options:
  -d <dir>      Output directory
  -S <session>  Create this screen-daemon as <session>
  -h            This help

Examples:
  ${SCREEND_START_SH_INFO} -S mydaemon

EOF
}
	while getopts S:h OPTION; do
		case $OPTION in
		h)
			clear
			print_screend.start_help $0
			exit 0
			;;
		S)
			SCREEN_SESSION_NAME="$OPTARG"
			;;
		?)
			echo "Syntax error:" 1>&2
			print_screend.start_help $0 1>&2
			exit 2
			;;

		esac
	done
	shift $(($OPTIND - 1))

	SCREEN_SESSION_NAME=${SCREEN_SESSION_NAME-"screend_cmd"}
	if [ ! $# -eq 0 ]; then
		echo "Syntax error: $(basename $0) takes"\
		     "no arguments" 1>&2
		echo 1>&2
		print_screend.start_help 1>&2
		exit 1
	fi

