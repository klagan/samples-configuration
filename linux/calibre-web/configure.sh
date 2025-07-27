# set environment variables
export CIFS_SERVER=192.168.0.0
export CIFS_SHARE=Public/Books
export MOUNT_POINT=/calibreweb/books
export CREDENTIALS_FILE=/calibreweb/.credentials
export OWNER_NAME=calibreweb
export OWNER_GROUP_NAME=calibreweb

# create user
useradd -m ${OWNER_NAME}

# create folders
mkdir /${OWNER_NAME} /${OWNER_NAME}/books /${OWNER_NAME}/db /${OWNER_NAME}/config

# map drives
./map-drive.sh

# download files
cp metadata.db /${OWNER_NAME}/db
cp docker-compose.yml /${OWNER_NAME}

# reset permissions
chown -R $(id -u ${OWNER_NAME}):$(id -g ${OWNER_NAME}) /${OWNER_NAME}

# add user to docker
sudo usermod -aG docker ${OWNER_NAME}
