#!/bin/bash
FILE="${1}"
OUTPUT_FOLDER="${2}"

if [[ ! -s "${FILE}" ]]; then
	echo "You must provide a non-empty hosts file as an argument."
	exit 1
fi


if [[ -z "${OUTPUT_FILE}" ]]; then
	OUTPUT_FILE="data"
fi


while read -r line; do
	url=$(echo "${line}" | xargs)
	if [[ -n "${url}" ]]; then
		echo "Testing ${url} for Directroy indexing..."
		if curl -L -s "${url}" | grep -q -e "Index of /" -e "[PARENTDIR]"; then
			echo -e "\t -!- Found Directory Indexing page at ${url}"
			echo -e "\t -!- Downloading to the \"${OUTPUT_FILE}\" folder..."
			mkdir -p "${OUTPUT_FOLDER}"
			wget -q -r -np -R "index.html*" "${url}" -p "${OUTPUT_FOLDER}"
		fi
	fi
done < <(cat "${FILE}")


# What if we want to run a scan against a list of URLs to check whether
# they enable directory indexing, then download all the files they serve?

# In this script, we define the FILE and OUTPUT_FOLDER variables. Their assigned values
# are taken from the arguments the user passes on the command line ($1 and $2).
# We the fail and exit the script (exit 1) if the FILE variable is not of the file
# type and of length zero (-s). If the file has a length of zero, it means the file is
# empty. We then use a while loop to read the file at the path assigned to the FILE
# variable. We ensure that each whitespace character in each line from the file is
# removed by pipping it to the xargs commands. We use curl to make an HTTP GET request
# and follow any HTTP redirects (using -L). We silence verbose output from curl
# (using -s) and pipe it to grep to find any instances of the strings Index of /
# and [PARENTDIR]. These two strings exist in directory indexing pages.
# If we find either string, we call the wget command with the quiet option (-q) to silence
# verbose output, the recursive option (-r) to download files recursively from folders,
# the no-parent option (-np) to ensure we download only files at the same level of
# hierarchy or lower (subfolders), and the reject option (-R) to exclude files
# starting with index.html. We then use the target folder option (-p) to download the
# content to the path specified by the user calling the script 
# (the OUTPUT_FILE variable). If the user didn't provide a destination folder, the
# script will default to using the data folder.
