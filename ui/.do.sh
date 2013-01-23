# UI part of futil.screend.do.sh
# This is not even a script, stupid and can't exist alone. It is purely
# ment for beeing included.

function print_screend.do_help() {
			cat <<EOF
Usage:
   ${SCREEND_DO_SH_INFO} [options] [--] <cmd> [<cmd_args>]

Let daemonized screen execute cmd instead of the sender. 
This is suitable for scripting commands to various X-sessions


Options:
  -d <dir>      Output directory
  -S <session>  Create this screen-daemon as <session>
  -h            This help

Examples:
  ${SCREEND_DO_SH_INFO} xpra detach :1234 
  ${SCREEND_DO_SH_INFO} 'export DISPLAY=\":0.1\" && xpra attach :1234 &'

EOF
}
	while getopts S:h OPTION; do
		case $OPTION in
		h)
			clear
			print_screend.do_help $0
			exit 0
			;;
		S)
			SCREEN_SESSION_NAME="$OPTARG"
			;;
		?)
			echo "Syntax error:" 1>&2
			print_screend.do_help $0 1>&2
			exit 2
			;;

		esac
	done
	shift $(($OPTIND - 1))

	SCREEN_SESSION_NAME=${SCREEN_SESSION_NAME-"screend_cmd"}
	if [ $# -eq 0 ]; then
		echo "Syntax error: $(basename $0) needs"\
		     "arguments" 1>&2
		echo 1>&2
		print_screend.do_help 1>&2
		exit 1
	fi

