# install packages
apt -y update && apt -y upgrade
apt install -y openvpn openresolv
apt autoremove

# proton specific configuration of AOVPN
wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
chmod +x "/etc/openvpn/update-resolv-conf"

# verify installations
sudo systemctl list-units --type=service --state=running

# assuming you have already downloaded your own ovpn file
echo "Configure OpenVPN: sudo openvpn <config.ovpn>"

export vpn_username=
export vpn_password=
export credentials_file=.vpn_credentials
export ovpn_filename=/root/ch.protonvpn.udp.ovpn

echo "${vpn_username}" | tee "${credentials_file}" > /dev/null
echo "${vpn_password}" | tee -a "${credentials_file}" > /dev/null

mv ${credentials_file} /etc/openvpn
chmod 600 /etc/openvpn/${credentials_file}

# configure vpn
cp ${ovpn_filename} /etc/openvpn/myvpn.conf

echo -e "\e[33mEDIT THIS LINE IN /etc/openvpn/myvpn.conf : auth-user-pass /etc/openvpn/.vpn_credentials\e[0m"
echo -e "\e[33mENABLE SERVICE: systemctl enable openvpn@myvpn.service\e[0m"
echo -e "\e[33mSTART SERVICE: systemctl start openvpn@myvpn.service\e[0m"
echo -e "\e[33mCHECK SERVICE: systemctl status openvpn@myvpn.service\e[0m"
echo -e "\e[33mVALIDATE: curl ipinfo.io\e[0m"

# troubleshooting
# journalctl -u openvpn@myvpn.service -f
