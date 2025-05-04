#!/bin/bash
FILE="output.txt"

touch "${FILE}"
until [[ -s "${FILE}" ]]; do
	echo "${FILE} is empty..."
	echo "Checking again in 2 seconds..."
	sleep 2
done

echo "${FILE} appears to have content in it!"


# We first create an empty file, then begin a loop that
# runs until the file is no longer empty -s.
