#!/bin/bash

# This function checks if the current user ID equals zero.
check_if_root(){     # (1)
	if [[ "${EUID}" -eq 0 ]]; then    #(2)
		return 0
	else
		return 1
	fi
}

if check_if_root; then
	echo "User is root!"
else
	echo "User is not root!"
fi
