#!/bin/bash
SIGNAL_TO_STOP_FILE="stoploop"   # (1)

while [[ ! -f "${SIGNAL_TO_STOP_FILE}" ]]; do   # (2)
	echo "The file ${SIGNAL_TO_STOP_FILE} does not exist..."
	echo "Checking again in 2 seconds..."
	sleep 2
done


echo "File ${SIGNAL_TO_STOP_FILE} was found! Exiting..."   # (3)
find "${SIGNAL_TO_STOP_FILE}"


# At (1), we define a variable representing the name of the file for which the while loop (2)
# checks, suing a file test operator. The loop won't exit until the condition is satisfied.
# Once the file is available, the loop will stop, and the script will continue to the echo
# command (3).
