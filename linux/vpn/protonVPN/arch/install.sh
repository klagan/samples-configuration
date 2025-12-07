#!/bin/bash

# get the directory where the script is located
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# use the absolute path
source "$SCRIPT_DIR/.env"

# install packages.
# '-Syu' performs a system update; '-S' installs packages. '--noconfirm' bypasses prompts.
pacman -Syu --noconfirm # System update/upgrade
pacman -S --noconfirm openvpn openresolv

# proton specific configuration of AOVPN
wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
chmod +x "/etc/openvpn/update-resolv-conf"

echo "$vpn_username" | tee "$vpn_credentials_file" > /dev/null
echo "$vpn_password" | tee -a "$vpn_credentials_file" > /dev/null

mv "$vpn_credentials_file" /etc/openvpn/
chmod 600 "/etc/openvpn/$vpn_credentials_file"

# configure vpn
cp "$vpn_ovpn_filename" /etc/openvpn/myvpn.conf

# include credentials file in the OpenVPN config
sed -i "s/^auth-user-pass$/auth-user-pass \/etc\/openvpn\/$vpn_credentials_file/" /etc/openvpn/myvpn.conf

# start services
systemctl enable openvpn@myvpn.service
systemctl start openvpn@myvpn.service

# validate vpn active
systemctl status openvpn@myvpn.service
curl ipinfo.io

# troubleshooting
# journalctl -u openvpn@myvpn.service -f
