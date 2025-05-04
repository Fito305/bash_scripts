#!/bin/bash


FILENAME="flow_of_control_with_if_2.txt"

if [[ ! -f "${FILENAME}" ]]; then
	touch "${FILENAME}"
fi


# A different way to test if a file exists. It uses the
# NOT operator (!) to check whether a directory doesn't exists and,
# if doesn't creates it.
# The -f file test operator test for the existence of the file.
