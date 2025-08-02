#!/bin/bash

SOURCE_FOLDERS=("/a" "/b" "/c") # list folders for backup
DESTINATION_USER=${BKUP_UID}
DESTINATION_HOST=${BKUP_ADDR}
DESTINATION_PATH=$(date +%Y%m%d%H%M%S)
DESTINATION_PORT=22
PASSWORD_FILE="./password.txt"

# use rsync in archive mode, compress during transfer, show progress
# the trailing slash on SOURCE_FOLDERS is important for rsync!
# it means "copy the CONTENTS of this folder", not the folder itself.
# us public key not password
# rsync -avz --progress \
#  -e "ssh -p ${DESTINATION_PORT}" \
#  "${SOURCE_FOLDERS[@]}" \
#  "${DESTINATION_USER}@${DESTINATION_HOST}:${DESTINATION_PATH}/"

sshpass -f "$PASSWORD_FILE" rsync -avz --progress \
  -e "ssh -p ${DESTINATION_PORT}" \
  "${SOURCE_FOLDERS[@]}" \
  "${DESTINATION_USER}@${DESTINATION_HOST}:${DESTINATION_PATH}/"

# you might want to add --delete if you want files removed locally to also be removed on the server.
# be careful with --delete! Always test with -n (dry run) first.
# rsync -avz --delete --progress "${SOURCE_FOLDERS[@]}" "${DESTINATION_USER}@${DESTINATION_HOST}:${DESTINATION_PATH}/"

# add a log message
echo "Backup completed on $(date)" >> /home/admin/logs/my_rsync_backup.log
