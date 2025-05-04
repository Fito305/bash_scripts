#!/bin/bash
HOSTS="$*"


if [[ "${EUID}" -ne 0 ]]; then
	echo "The Nmap OS detection scan type (-0) requires root privileges."
	exit 1
fi


if [[ "$#" -eq 0 ]]; then 
	echo "You must pass an IP or an IP range."
fi


echo "Running an OS detection Scane against ${HOSTS}..."


nmap_scan=$(sudo nmap -0 ${HOSTS} -oG -)
while read -r line; do
	ip=$(echo "${line}" | awk '{print $2}')
	os=$(echo "${line}" | awk -F'OS: ' '{print $2}' | sed 's/Seq.*//g')
	if [[ -n "${ip}" ]] && [[ -n "${os}" ]]; then
		echo "IP: ${ip} OS: ${os}"
	fi
done
