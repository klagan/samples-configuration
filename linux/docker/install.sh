apt update
apt -y upgrade
apt autoremove

# install docker
sudo curl -fsSL https://get.docker.com | sh

# verify installations
docker version
docker compose version

# add self to docker group
echo -e "Add self to docker:\e[1;32msudo usermod -aG docker $USER\e[0m"
