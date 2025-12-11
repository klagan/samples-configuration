# 1. Stop and disable the systemd service
sudo systemctl stop cloudflared
sudo systemctl disable cloudflared

# 2. Uninstall the package and remove config files
sudo apt purge cloudflared -y

# 3. Clean up any remaining service files (important if purge fails)
sudo rm -f /etc/systemd/system/cloudflared.service
sudo rm -f /etc/systemd/system/cloudflared-update.service
sudo rm -f /etc/systemd/system/cloudflared-update.timer
sudo systemctl daemon-reload # Reload systemd after manual removal

# 4. Remove the cloudflared binary (if not removed by purge)
sudo rm -f /usr/local/bin/cloudflared
sudo rm -f /usr/bin/cloudflared

# 5. Remove the config directory and credentials (often left behind)
sudo rm -rf /etc/cloudflared/
rm -rf ~/.cloudflared/

# 6. Remove the apt repository and GPG key
sudo rm -f /etc/apt/sources.list.d/cloudflared.list
sudo rm -f /usr/share/keyrings/cloudflare-main.gpg
sudo apt update

# 7. [IF ALL CONNECTORS ARE DELETED]: Log in to your Cloudflare Dashboard and delete the tunnel from the Zero Trust > Tunnels section. IF YOU ARE DEL
