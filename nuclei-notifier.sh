#!/bin/bash
EMAIL_TO="felipe.acosta002@gmail.com"
EMAIL_FROM="nuclei-automation@blackhat.com"


for ip_address in "$@"; do
	echo "Testing ${ip_address} with Nuclei..."
	result=$(nuclei -u ${ip_address}" -silent -severity medium,high,critical)	if [[ -n "${result}" ]]; then
	 while read -r line; do
		template=$(echo "${line}" | awk '{print $4}' | tr -d '[]')
		url=$(echo "${line}" | awk '{print$4}')
		echo "Sending an email with the findings ${template} ${url}"
		sendemail -f "${EMAIL_FROM}" \
			  -t "${EMAIL_TO}" \
			  -u "[Nuclei] Vulnerability Found!" \
			  -m "${template} - ${url}"
  	 done <<< "${result}"
       fi
done



# We use a for loop to iterate through values in the $@ variable that
# contains the arguments passed to the script on the command line.
# We assign each argument to the ip_address variable. Next, we run a
# Nuclei scan, passing it the --severity argument to scan for vulnerabilities
# categorized as either medium, high or critical and save the output to the
# result variable. We read the output passed to the while loop line by line.
# For each line, we extract the first field, using the tr -d '[]' command to
# removed the [] character for a cleaner output. We also extract the fourth
# field from each line, which is where Nuclei stores the vulnerable URL.
# We send an email containing the relevant information.
# To run this script, save it to a file and pass the IP addresses to scan
# on the command line:
# $ nuclei-notifier.sh 172.16.10.10:8081 172.16.10.11 172.16.10.12
