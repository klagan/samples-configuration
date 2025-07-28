# stop docker service
systemctl stop docker

# remove docker packages
apt purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras -y
apt purge docker docker-engine docker.io containerd runc -y

# remove docker data
rm -rf /var/lib/docker
rm -rf /var/lib/containerd

# remove docker configuration files

# docker GPG key
rm -f /etc/apt/keyrings/docker.gpg

# docker repository entry from sources.list.d
rm -f /etc/apt/sources.list.d/docker.list

# update package lists
sudo apt update

# remove docker group
delgroup docker

# reboot
reboot
