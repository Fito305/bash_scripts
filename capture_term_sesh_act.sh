#!/bin/bash

FILENAME=$(date +%m_%d_%Y_%H:%M:%S).log


if [[ ! -d ~/sessions ]]; then
	mkdir ~/sessions
fi


# Starting a script session
if [[ -z $SCRIPT ]]; then 
	export SCRIPT="/home/Destop/bash/sessions/${FILENAME}"
	script -q -f "${SCRIPT}"
fi


# Having ~/.bashrc load this script via source/ or export,
#  will result in the
# creation of the ~/sessions directory, containing each terminal session
# capture in a separate file. The recoding stops when you enter exit in
# the terminal or close the terminal window.
