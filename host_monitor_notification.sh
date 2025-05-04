#!/bin/bash

# Send a notification upon new host discovery
KNOWN_HOSTS="172-16-10-hosts.txt"
NETWORK="172.16.10.0/24"
INTERFACE="br_public"
FROM_ADDR="kali@blackhatbash.com"
TO_ADDR="security@blackhatbash.com"

while true; do   # (1)
	echo "Performing an ARP scan against ${NETWORK}..."

	sudo arp-scan -x -I ${INTERFACE} ${NETWORK} | while read -r line; do  # (2)
		host=$(echo "${line}" | awk '{print $1}')  # (3)
		if ! grep -q "${host}" "${KNOWN_HOSTS}"; then  # (4)
			echo "Found a new host: ${host}!"
			echo "${host}" >> "${KNOWN_HOSTS}"  # (5)
			sendemail -f "${FROM_ADDR}" \  # (6)
				-t "${TO_ADDR}" \
				-u "ARP Scan Notification" \
				-m "A new host was found: ${host}"
		fi
	done


	sleep 10
done


# Fist, we set a few variables. We assign the file containing the hosts to look for,
# 172-16-10-hosts.txt, to the KNOWN_HOSTS variable, and the target network 
# 172.16.10.0/24 to the NETWORK variable. We also set the FROM_ADDR and TO_ADDR vaiables,
# which we'll use to send the notification email.
# We then use the while to run an infinite loop (1). This loop won't end unless
# we intentionally break out of it. Within the loop, we run arp-scan with the options
# -x to display a plain output (so it's easier to parse) and -I to define
# the network interface br_public (2). In the same line, we use a while read
# loop to iterate through the output of arp-scan. We use awk to parse each IP address in
# the output and assign it to the host variable (3).
# At (4), we use an if condition to check whether the host variable (which represents a host
# discovered by arp-scan) exists in our host file. If it does, we don't do anything,
# but if it doesn't, we write it to the file (5) and send an email notification (6) by using
# the sendemail command. Notice that each line in the sendemail command ends with a backslash (\).# When lines are long, bash allows us to seperate them in this way still treating them as a
# single command. Breaking long code lines makes them easier to read. At the end of
# this process, we use sleep 10 to wait 10 seconds before running this discovery again.
