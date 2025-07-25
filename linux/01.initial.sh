apt update
apt -y full-upgrade
apt autoremove
apt install -y ufw openvpn openresolv vim lynx lynis rkhunter apt-listbugs needrestart fail2ban clamav clamav-daemon nginx

wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
chmod +x "/etc/openvpn/update-resolv-conf"

# assuming you have already downloaded your own ovpn file
echo "RUN: sudo openvpn <config.ovpn>"
