# install packages
apt update
apt -y full-upgrade
apt install openvpn openresolv -y
apt autoremove

# proton specific configuration of AOVPN
wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
chmod +x "/etc/openvpn/update-resolv-conf"

# verify installations
sudo systemctl list-units --type=service --state=running

# assuming you have already downloaded your own ovpn file
echo "Configure OpenVPN: sudo openvpn <config.ovpn>"
