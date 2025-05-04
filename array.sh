#!/bin/bash

# Sets an array
IP_ADDRESSES=(192.168.1.1 192.168.1.12 192.168.1.3)
unset IP_ADDRESSES[1]

# Print all elements in the array.
echo "${IP_ADDRESSES[*]}"

# Prints only the first element in the array
echo "${IP_ADDRESSES[0]}"
