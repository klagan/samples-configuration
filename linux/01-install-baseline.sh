apt update
apt upgrade -y
apt install vim lynx curl glances apt-listbugs neofetch -y
apt autoremove

# install pi apps appstore
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash

# set up swap space (if not already configured)
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# optimize system settings
sysctl -w vm.swappiness=10
sysctl -w vm.vfs_cache_pressure=50

# verify installations
systemctl list-units --type=service --state=running
