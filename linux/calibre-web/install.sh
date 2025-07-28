# set environment variables
export CIFS_SERVER=192.168.0.0                       # network server address to map to
export CIFS_SHARE=Public/Books                       # network share name to map to
export MOUNT_POINT=/calibreweb/books                 # change only if required
export CREDENTIALS_FILE=/calibreweb/.credentials     # change only if required
export OWNER_NAME=calibreweb                         # change only if required 
export OWNER_GROUP_NAME=calibreweb                   # change only if required

# create user
useradd -m ${OWNER_NAME}

# create folders
mkdir /${OWNER_NAME} /${OWNER_NAME}/books /${OWNER_NAME}/db /${OWNER_NAME}/config

# map drives
../tools/map-drive.sh

# download files
cp metadata.db /${OWNER_NAME}/db
cp docker-compose.yml /${OWNER_NAME}

# reset permissions
chown -R $(id -u ${OWNER_NAME}):$(id -g ${OWNER_NAME}) /${OWNER_NAME}
