#!/bin/bash


if [[ ! -r "/etc/passwd" ]]; then
    echo "/etc/passwd must exist and be readable to be able to continue."
    exit 1
fi


while read -r line; do
    account=$(echo "${line}" | awk -F':' '{print $1}')
    home_dir=$(echo "${line}" | awk -F':' '{print $6}')

    # Target only home directories under /home.
    if echo "${home_dir}" | grep -q "^/home"; then
        if [[ -r "${home_dir}" ]]; then
            echo "Home directory ${home_dir} of ${account} is accessible!"
        else
            echo "Home directory ${home_dir} of ${account} is NOT accessible!"
        fi
    fi
done < <(cat "/etc/passwd")


# In a while loop, we read the /etc/passwd file line by line. We assign the
# account and home_dir variables to the first and sixth fields of each line,
# respectively. We then check whether the home directory starts with the string
# /home by using the caret (^) character and the grep -q (quite) option so
# that the output of the command won't be printed to the standard output stream.
# If our previous check succeeded, we check whether the home directory is readable
# with -r and print the result to the screen.
