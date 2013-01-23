#!/bin/bash
# Author: Michael Ambrus (ambrmi09@gmail.com)
# 2013-01-23

if [ -z $DO_SH ]; then

DO_SH="do.sh"

function screend.do() {
	screen \
		-S ${SCREEN_SESSION_NAME} \
		-p0 \
		-X stuff "${@}"`echo -ne '\015'`
}

source s3.ebasename.sh
if [ "$DO_SH" == $( ebasename $0 ) ]; then
	#Not sourced, do something with this.

	SCREEND_DO_SH_INFO=${DO_SH}

	source .screend.ui..do.sh

	tty -s; ATTY="$?"
	ISATTY="$ATTY -eq 0"

	#set -e
	#set -u


	screend.do "$@"

	RC=$?

	exit $RC
fi

fi

