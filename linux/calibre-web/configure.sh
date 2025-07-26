# create user
useradd -m calibreweb

# create folders
mkdir /calibreweb /calibreweb/books /calibreweb/db /calibreweb/config
chown -R $(id -u calibreweb):$(id -g calibreweb) /calibreweb

# set environment variables
export CIFS_SERVER=192.168.0.0
export CIFS_SHARE=Public/Books
export MOUNT_POINT=/calibreweb/books
export CREDENTIALS_FILE=/calibreweb/.credentials
export OWNER_NAME=calibreweb
export OWNER_GROUP_NAME=calibreweb

./map-drive.sh
