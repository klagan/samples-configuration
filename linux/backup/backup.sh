#!/bin/bash

SOURCE_FOLDERS="/home/pi/documents/ /home/pi/photos/" # add all folders you want to backup
DESTINATION_USER=${BKUP_UID}
DESTINATION_HOST=${BKUP_ADDR}
DESTINATION_PATH=$(date +%Y%m%d%H%M%S)

# use rsync in archive mode, compress during transfer, show progress
# the trailing slash on SOURCE_FOLDERS is important for rsync!
# it means "copy the CONTENTS of this folder", not the folder itself.
rsync -avz --progress \
  "${SOURCE_FOLDERS[@]}" \
  "${DESTINATION_USER}@${DESTINATION_HOST}:${DESTINATION_PATH}/"

# you might want to add --delete if you want files removed locally to also be removed on the server.
# be careful with --delete! Always test with -n (dry run) first.
# rsync -avz --delete --progress "${SOURCE_FOLDERS[@]}" "${DESTINATION_USER}@${DESTINATION_HOST}:${DESTINATION_PATH}/"

# add a log message
echo "Backup completed on $(date)" >> /var/log/my_rsync_backup.log
