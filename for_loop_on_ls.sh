#!/bin/bash

for file in $(ls .); do
	echo "File: ${file}"
done


# This technique would be useful, for example, if we
# wanted to perform an upload of all files in the
# directory or even rename them in bulk.
