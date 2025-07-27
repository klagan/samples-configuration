# install packages
apt -y update
apt full-upgrade
apt install -y openvpn openresolv
apt autoremove

# proton specific configuration of AOVPN
wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
chmod +x "/etc/openvpn/update-resolv-conf"

# verify installations
sudo systemctl list-units --type=service --state=running

# assuming you have already downloaded your own ovpn file
echo "Configure OpenVPN: sudo openvpn <config.ovpn>"
