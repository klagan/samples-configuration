# this script configures the ufw to the requirements of twingate
# twingate only requires OUTBOUND ports

apt update
apt -y upgrade
apt -y install ufw
apt autoremove

echo "--- Starting UFW Configuration ---"

# reset UFW to a clean state. - removes all existing rules and restores the default policies.
echo "Resetting UFW to a clean state..."
sudo ufw --force reset

# set default policies to deny incoming and allow outgoing.
echo "Setting default policies: deny incoming, allow outgoing."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# allow outbound TCP traffic on port 443 (HTTPS)
sudo ufw allow out to any port 443 proto tcp

# allow outbound TCP traffic on ports 30000-31000
sudo ufw allow out to any port 30000:31000 proto tcp

# allow outbound UDP traffic on all ports
sudo ufw allow out to any proto udp

# allow ssh from nodes on the local network
sudo ufw allow in from 192.168.86.0/24 to any port 22 proto tcp
