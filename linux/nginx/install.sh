apt update
apt -y upgrade
apt autoremove
apt -y install nginx

# verify installations
nginx -v
systemctl status nginx
