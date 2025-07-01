#!/bin/bash
TARGET=("$@") # (1)


print_help(){
    echo "Usage: ${0} <LIST OF IPS>"
    echo "${0} 10.1.0.1 10.1.0.2 10.1.0.3"
}

if [[ ${#TARGET[@]} -eq 0 ]]; then  # (2)
    echo "Must provide one or more IP addresses!"
    print_help # (3)
    exit 1
fi

for target in "${TARGETS[@]}"; do  # (4)
    while read -r port; do
        if timeout 1 nc -i 1 "${target}" -v "${port}" 2>&1 | grep -q "Connected to"; then  # (5)
            echo "IP: ${target}"
            echo "Port: ${port}"
            echo "Service: $(grep -w "${port}/tcp" /etc/services | awk '{print $1}')"
        fi
    done < <(grep "/tcp" /etc/services | awk '{print $2}' | tr -d '/tcp')  # (6)
done


# At (1), we define the TARGETS=() array variable, using "$@"
# inside the parentheses to assign any command line arguments passed to
# the script to this array. We then use an if condition to check
# whether the TARGETS array is empty (2). If so, we print a
# help message (3) by using the print_help() function.
# We iterate through the TARGETS array (4). We also iterate through
# all the TCP ports in /etc/services by using a while loop (6), then
# connect to the target and port by using the nc command (5). If the
# port is found open, we print the target, the port, and the service
# name mapping from /etc/services.
