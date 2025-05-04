#!/bin/bash
DIR_NAME="dir_test"

mkdir="${DIR_NAME}"

if [[ -f "${DIR_NAME}" ]] || [[ -d "${DIR_NAME}" ]]; then
	echo "${DIR_NAME} is either a file or a directory."
fi


# This code first creates a directory, then uses an if condition with th
# OR (||) operator to check whether the variable is a file (-f) or a 
# directory (-d). The second condition should evaluate to true, and then
# the echo command should execute.
