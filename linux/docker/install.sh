apt update
apt -y upgrade
apt autoremove

# install docker
sudo curl -fsSL https://get.docker.com | sh

# verify installations
docker version
docker compose version

# message to user: add self to docker group
echo -e "\n\e[1;31mNOTE:\e[0m Add self to docker:\e[1;32m sudo usermod -aG docker \$USER\e[0m"
