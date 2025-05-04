#!/bin/bash

# This script will ping any address provided as an argument.


SCRIPT_NAME="${0}"
TARGET="${1}"

echo "Running the script ${SCRIPT_NAME}..."
echo "Pinging the target: ${TARGET}..."
ping "${TARGET}"


# This script assigns the first positional argument to the variable
# TARGET. Notice alos, that the argument ${0} is assigned to the
# SCRIPT_NAME variable. This argument contains the script's name
# in this case, ping_with_args.sh.
