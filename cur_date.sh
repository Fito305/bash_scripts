#!/bin/bash
CURRENT_DATE=$(date +%y-%m-%d)


if [[ ! -d "/data/backup" ]]; then
    mkdir -p /data/backup
fi


# Look for external instructions if they exist.
for directory in "/tmp" "/data"; do
    if [[ -f "${directory}/extra_cmds.sh" ]]; then
        source "${directory}/extra_cmds.sh"
    fi
done


# Back up the data directory.
echo "Backing up /data/backup - ${CURRENT_DATA}"


tar czvf "/data/backup-${CURRENT_DATE}.tar.gz" /data/backup


echo "Done."


# The script first sets the CURRENT_DATE variable with today's date.
# Then a for loop iterates over the /tmp and /data directories and tests
# whether the file extra_cmds.sh exists in each directory. If the script
# finds the file, the source command copies the extra_cmds.sh script into
# the currently executing script, which runs all its instructions in the
# same shell. Next, a tar command compresses the contents of /data/backup
# into a single tar.gz file under /data. The script then removes any content
# left in /data/backup. 
#
# # This script contains a vulnerability; it doesn't take into
# consideration that /tmp is a world-accessible directory. If the
# extra_cmds.sh file doesn't exist, someone could potentially create on,
# the introduce additional instructions for the cron job to execute.
# In addition, the /data directory is also world-writable because of what
# seems to be a misconfiguration.
