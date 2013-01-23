#!/bin/bash
# Author: Michael Ambrus (ambrmi09@gmail.com)
# 2013-01-23

if [ -z $START_SH ]; then

START_SH="start.sh"

function screend.start() {
	CURR_SCREEN_SESSION_NAME=$(
		screen -ls | \
		grep "^[[:space:]][[:digit:]]\+\.${SCREEN_SESSION_NAME}[[:space:]]"
	)
	#echo "This is the current screen name: ${CURR_SCREEN_SESSION_NAME}"
	#exit 0
	if [ "X$(echo ${CURR_SCREEN_SESSION_NAME} | \
			grep ${SCREEN_SESSION_NAME} | wc -l)" == "X0" ]; then
		echo "Starting a new daemonized screen as [${SCREEN_SESSION_NAME}]"
		#Start a new daemonized screen
		screen -dmS ${SCREEN_SESSION_NAME}
	elif [ "X$(echo ${CURR_SCREEN_SESSION_NAME} | \
			grep ${SCREEN_SESSION_NAME} | wc -l)" == "X1" ]; then
		echo "Using screen-session " \
			"[`echo ${CURR_SCREEN_SESSION_NAME} | \
				sed -e 's/[[:space:]]/ /g'`]" 1>&2
	else
		echo "Error: More than one valid screen sessions found:" 1>&2
		echo ${CURR_SCREEN_SESSION_NAME} 1>&2
	fi
}

source s3.ebasename.sh
if [ "$START_SH" == $( ebasename $0 ) ]; then
	#Not sourced, do something with this.

	SCREEND_START_SH_INFO=${START_SH}

	source .screend.ui..start.sh

	tty -s; ATTY="$?"
	ISATTY="$ATTY -eq 0"

	#set -e
	#set -u


	screend.start "$@"

	RC=$?

	exit $RC
fi

fi

