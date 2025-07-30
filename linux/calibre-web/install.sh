# set environment variables
export CIFS_SERVER=192.168.0.0                         # network server address to map to
export CIFS_SHARE=Public/Books                         # network share name to map to
export MOUNT_POINT=/opt/calibreweb/books               # change only if required
export CREDENTIALS_FILE=/opt/calibreweb/.credentials   # change only if required
export OWNER_NAME=calibreweb                           # change only if required 
export OWNER_GROUP_NAME=calibreweb                     # change only if required

# create user
useradd -m ${OWNER_NAME}

# create folders
mkdir /opt/calibreweb /opt/calibreweb/books /opt/calibreweb/db /opt/calibreweb/config

# map drives
../tools/map-drive.sh

# download files
cp metadata.db /opt/calibreweb/db
cp docker-compose.yml /opt/calibreweb

# reset permissions
chown -R $(id -u ${OWNER_NAME}):$(id -g ${OWNER_GROUP_NAME}) /opt/calibreweb
