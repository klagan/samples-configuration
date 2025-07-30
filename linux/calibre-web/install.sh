# set environment variables
export CIFS_SERVER=192.168.0.0                         # network server address to map to
export CIFS_SHARE=Public/Books                         # network share name to map to
export MOUNT_POINT=/calibre/books                      # change only if required
export CREDENTIALS_FILE=/calibre/.credentials          # change only if required
export OWNER_NAME=calibreweb                           # change only if required 
export OWNER_GROUP_NAME=calibreweb                     # change only if required

# create user
useradd -m ${OWNER_NAME}

# create folders
mkdir /calibre /calibre/books /calibre/db /calibre/config

# map drives
../tools/map-drive.sh

# download files
cp metadata.db /calibre/db
cp docker-compose.yml /calibre

# reset permissions
chown -R $(id -u ${OWNER_NAME}):$(id -g ${OWNER_GROUP_NAME}) /calibre
