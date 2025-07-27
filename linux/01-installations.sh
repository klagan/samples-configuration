apt update
apt -y full-upgrade
apt autoremove
apt install ufw vim lynx lynis rkhunter apt-listbugs needrestart fail2ban clamav clamav-daemon nginx samba-client netdiscover cifs-utils nfs-common ca-certificates curl gnupg lsb-release -y

# install docker
sudo curl -fsSL https://get.docker.com | sh

# set up swap space (if not already configured)
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# optimize system settings
sudo sysctl -w vm.swappiness=10
sudo sysctl -w vm.vfs_cache_pressure=50

# verify installations
docker version
docker compose version
nginx -v
systemctl status nginx
sudo systemctl list-units --type=service --state=running

# add self to docker group
echo Add user to docker: sudo usermod -aG docker $USER
