#!/bin/bash
FILENAME="flow_control_with_if.txt"

if [[ -f "${FILENAME}" ]]; then
	echo "${FILENAME} already exists."
	exit 1
else
	touch "${FILENAME}"
fi

# -f file test operator test for the existence of the file.
# If the file exists we exit with 1 (failure) to exit the program.
