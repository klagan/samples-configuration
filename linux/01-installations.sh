apt update
apt -y full-upgrade
apt autoremove
apt install -y ufw openvpn openresolv vim lynx lynis rkhunter apt-listbugs needrestart fail2ban clamav clamav-daemon nginx samba-client netdiscover cifs-utils nfs-common ca-certificates curl gnupg lsb-release

# proton specific configuration of AOVPN
wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
chmod +x "/etc/openvpn/update-resolv-conf"

# assuming you have already downloaded your own ovpn file
echo "Configure OpenVPN: sudo openvpn <config.ovpn>"

# install docker
sudo curl -fsSL https://get.docker.com | sh

# add self to docker group
echo Add user to docker: sudo usermod -aG docker $USER

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
docker -v
nginx -v
systemctl status nginx
sudo systemctl list-units --type=service --state=running
