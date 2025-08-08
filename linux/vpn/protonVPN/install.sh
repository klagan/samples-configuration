
## EDIT VARIABLES HERE <----------------------------------------------------------------------
export vpn_username=                              # your vpn username
export vpn_password=                              # your vpn password
export credentials_file=.vpn_credentials          # change only if you need a different name
export ovpn_filename=./ch.protonvpn.udp.ovpn  # change this to your own openvpn file

# install packages
apt -y update && apt -y upgrade
apt install -y openvpn openresolv
apt autoremove

# proton specific configuration of AOVPN
wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
chmod +x "/etc/openvpn/update-resolv-conf"

echo "${vpn_username}" | tee "${credentials_file}" > /dev/null
echo "${vpn_password}" | tee -a "${credentials_file}" > /dev/null

mv ${credentials_file} /etc/openvpn
chmod 600 /etc/openvpn/${credentials_file}

# configure vpn
cp ${ovpn_filename} /etc/openvpn/myvpn.conf

# include credentials file
sed -i 's/^auth-user-pass$/auth-user-pass \/etc\/openvpn\/.vpn_credentials/' /etc/openvpn/myvpn.conf

# start services
systemctl enable openvpn@myvpn.service
systemctl start openvpn@myvpn.service

# validate  vpn active
systemctl status openvpn@myvpn.service
curl ipinfo.io

# troubleshooting
# journalctl -u openvpn@myvpn.service -f
