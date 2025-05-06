#!/bin/bash
TARGET_URL="http://172.16.10.12"
ROBOTS_FILE="robots.txt"


while read -r line; do
	path=$(echo "${line}" | awk -F'Disallow: ' '{print $2}')
	if [[ -n "${path}" ]]; then
		url="${TARGET_URL}${path}"
		status_code=$(curl -s -o /dev/null -w "%{http_code}" "${url}")
		echo "URL: ${url} returned a status code of: ${status_code}"
	fi

done < <(curl -s "${TARGET_URL}/${ROBOT_FILE}")


# We read the output from the curl command line by line. This command
# makes an HTTP GET request to http://172.16.10.12/robots.txt.
# We then parse each line and grab the second field (which is separated from
# the others by a space) to extract the path and assign it to the path variable.
# We check that the path variable length is greater than zero to ensure we were
# able to properly parse it.
# Then we create a url variable, which is a string concatenated from the
# TARGET_URL variable plus each path from the robots.txt file, and make
# an HTTP request to the URL. We use the -w (write out) variable %{http_code}
# to extract only the status code from the response returned by the web
# server. To go beyond this script, try using other curl variables.
