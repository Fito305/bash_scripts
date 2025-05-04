#/bin/bash
NAME="${1}"
DOMAIN="${2}"
OUTPUT_FILE="results.csv"


# Check if the two expected arguments are set
if [[ -z "{NAME}" ]] || [[ -z "${DOMAIN}" ]]; then
	echo "You muest provide two arguments to this script."
	echo "Example: ${0} mysite nostarch.com"
	exit 1
fi


# Write CSV header to file
if ping -c 1 "${DOMAIN}" &> /dev/null; then
	echo "success,${NAME},${DOMAIN},$(date)" >> "${OUTPUT_FILE}"
else
	echo "failure,${NAME},${DOMAIN},$(date)" >> "${OUTPUT_FILE}"
fi


# Write a bash script that accepts two arguments: a name (for example,
# mysite) and a target domain (for example, nostarch.com).
# The script should be able to do the following:
# 1. Throw an error if the arguments are missing and exit using the right
#    exit code.
# 2. Ping the domain and return an indication of whether the ping was 
#    successful.
# 3. Write the result to a CSV file containing the following info:
#    a. The name provided to the script.
#    b. The target domain provided to the script.
#    c. The ping result (either success or failure)
#    d. The current data and time.
