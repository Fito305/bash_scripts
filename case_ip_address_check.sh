#!/bin/bash
IP_ADDRESS="${1}"

case ${IP_ADDRESS} in
	192.168.*)
		echo "Network is 192.168.x.x"
	;;
	10.0.*)
		echo "Network is 10.0.x.x"
	;;
	*)
		echo "Could not find the network"
	;;
esac



# We define a variable that expects one command line argument to be passed (${1}) and saves it to IP_ADDRESS variable.
# We then use a pattern to check whether the IP_ADDRESS variable starts with 192.168. and a second pattern to check whether it starts
# with 10.0. We also define a wildcard pattern using *, which returns a default message to the user if nothing
# else has matched.
