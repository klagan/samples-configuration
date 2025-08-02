apt update
apt -y upgrade
apt -y install samba-client netdiscover cifs-utils nfs-common ca-certificates
apt autoremove

# verify installations
systemctl list-units --type=service --state=running
