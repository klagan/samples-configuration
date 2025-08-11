###-----> copy, edit and run on the client side <-----

# set environment variables
export CIFS_SERVER=192.168.0.0                         # network server address to map to (destination)
export CIFS_SHARE=Backups                              # network folder mount point to map to (destination)
export MOUNT_POINT=/backups/                           # local mount point to map to (source)
export CREDENTIALS_FILE=/backups/.credentials          # change only if required - credentials require to map to remote location
export OWNER_NAME=backup                               # change only if required - local owner user name
export OWNER_GROUP_NAME=backup                         # change only if required - local owner group name

# create user
useradd -m ${OWNER_NAME}                                                       # create the local user

# create folders
mkdir -p ${MOUNT_POINT}                                                        # create any folders required

# map drives
.//map-drive.sh                                                                # run the map-drive script

# reset permissions
chown -R $(id -u ${OWNER_NAME}):$(id -g ${OWNER_GROUP_NAME}) ${MOUNT_POINT}    # set owners on root folders created above
